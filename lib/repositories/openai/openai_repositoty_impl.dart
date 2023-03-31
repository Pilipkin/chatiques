import 'package:chatiques/data_sources/openai_remote_data_source.dart';
import 'package:chatiques/models/open_ai_response/message.dart';
import 'package:chatiques/models/open_ai_response/open_ai_response.dart';
import 'package:dio/dio.dart';

import 'openai_repository.dart';

class OpenAIRepositoryImpl implements OpenAIRepository {
  final OpenaiRemoteDataSource _openaiRemoteDataSource =
      OpenaiRemoteDataSource();

  @override
  Future<Stream<OpenAIResponse>?> getCompletion(String question,
      List<Message> previousMessages, CancelToken cancelToken) {
    return _openaiRemoteDataSource.getCompletion(
        question, previousMessages, cancelToken);
  }
}
