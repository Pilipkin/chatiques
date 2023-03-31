import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:chatiques/common/services/api_service.dart';
import 'package:chatiques/common/services/locator.dart';
import 'package:chatiques/models/open_ai_response/message.dart';
import 'package:chatiques/models/open_ai_response/open_ai_response.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_dotenv/flutter_dotenv.dart';

const _openAIUrl = 'https://api.openai.com/v1/chat/completions';
// const _apiKey = 'Bearer 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';
final _apiKey = dotenv.get('OPENAI_API_KEY');

const _model = 'gpt-3.5-turbo';
const _temperature = 0.8;

class OpenaiRemoteDataSource {
  final ApiService _apiService = locator<ApiService>();

  Future<Stream<OpenAIResponse>?> getCompletion(String question,
      List<Message> prevoiusMessages, CancelToken cancelToken) async {
    try {
      final response = await _apiService.dio.post<ResponseBody>(
        _openAIUrl,
        options: Options(
          headers: {
            "Accept": "text/event-stream",
            'Authorization': _apiKey,
          },
          responseType: ResponseType.stream,
        ),
        data: {
          'model': _model,
          'temperature': _temperature,
          'messages': [
            ...prevoiusMessages
                .map((e) => {'role': e.role, 'content': e.content}),
            {'role': 'user', 'content': question}
          ],
          'stream': true
        },
        cancelToken: cancelToken,
      );

      return response.data?.stream
          .transform(StreamTransformer.fromHandlers(
            handleData: (Uint8List data, EventSink<List<int>> sink) {
              sink.add(List<int>.from(data));
            },
          ))
          .transform(const Utf8Decoder())
          .transform(const LineSplitter())
          .transform(StreamTransformer.fromHandlers(
            handleData: (String data, EventSink<OpenAIResponse> sink) {
              final raw = data.replaceAll("data: ", '').trim();
              if (raw.isNotEmpty && raw != '[DONE]') {
                final jsonData = json.decode(raw);
                if (jsonData is! Map<String, dynamic>) {
                  return;
                }
                sink.add(OpenAIResponse.fromJson(jsonData));
              }
            },
          ));
    } catch (e) {
      return null;
    }
  }
}
