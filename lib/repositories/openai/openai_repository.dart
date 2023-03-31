import 'package:chatiques/models/open_ai_response/message.dart';
import 'package:chatiques/models/open_ai_response/open_ai_response.dart';
import 'package:dio/dio.dart';

abstract class OpenAIRepository {
  Future<Stream<OpenAIResponse>?> getCompletion(
      String question, List<Message> previousMessages, CancelToken cancelToken);
}
