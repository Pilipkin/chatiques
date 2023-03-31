// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_ai_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenAIResponse _$OpenAIResponseFromJson(Map<String, dynamic> json) =>
    OpenAIResponse(
      id: json['id'] as String,
      object: json['object'] as String?,
      created: json['created'] as int?,
      model: json['model'] as String?,
      choices: (json['choices'] as List<dynamic>)
          .map((e) => OpenAIChoice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OpenAIResponseToJson(OpenAIResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'created': instance.created,
      'model': instance.model,
      'choices': instance.choices,
    };

OpenAIChoice _$OpenAIChoiceFromJson(Map<String, dynamic> json) => OpenAIChoice(
      index: json['index'] as int,
      delta: ChoiceDelta.fromJson(json['delta'] as Map<String, dynamic>),
      finishReason: json['finish_reason'],
    );

Map<String, dynamic> _$OpenAIChoiceToJson(OpenAIChoice instance) =>
    <String, dynamic>{
      'delta': instance.delta,
      'index': instance.index,
      'finish_reason': instance.finishReason,
    };

ChoiceDelta _$ChoiceDeltaFromJson(Map<String, dynamic> json) => ChoiceDelta(
      content: json['content'] as String?,
    );

Map<String, dynamic> _$ChoiceDeltaToJson(ChoiceDelta instance) =>
    <String, dynamic>{
      'content': instance.content,
    };
