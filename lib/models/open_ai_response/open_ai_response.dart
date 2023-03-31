import 'package:json_annotation/json_annotation.dart';

part 'open_ai_response.g.dart';

@JsonSerializable()
class OpenAIResponse {
  final String id;
  final String? object;
  final int? created;
  final String? model;
  final List<OpenAIChoice> choices;

  OpenAIResponse({
    required this.id,
    this.object,
    this.created,
    this.model,
    required this.choices,
  });

  factory OpenAIResponse.fromJson(Map<String, dynamic> json) =>
      _$OpenAIResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OpenAIResponseToJson(this);
}

@JsonSerializable()
class OpenAIChoice {
  final ChoiceDelta delta;
  final int index;
  @JsonKey(name: 'finish_reason')
  final dynamic finishReason;

  OpenAIChoice(
      {required this.index, required this.delta, required this.finishReason});

  factory OpenAIChoice.fromJson(Map<String, dynamic> json) =>
      _$OpenAIChoiceFromJson(json);

  Map<String, dynamic> toJson() => _$OpenAIChoiceToJson(this);
}

// {
//   "id":"chatcmpl-6xaiXEIvnmSifHV4XzqB4kl5BGpae",
//   "object":"chat.completion.chunk",
//   "created":1679660513,
//   "model":"gpt-3.5-turbo-0301",
//   "choices":
//   [
//     {
//       "delta":
//       {
//         "content":"?"
//       },
//       "index":0,
//       "finish_reason":null
//     }
//   ]
// }

@JsonSerializable()
class ChoiceDelta {
  final String? content;

  ChoiceDelta({this.content});

  factory ChoiceDelta.fromJson(Map<String, dynamic> json) =>
      _$ChoiceDeltaFromJson(json);

  Map<String, dynamic> toJson() => _$ChoiceDeltaToJson(this);
}
