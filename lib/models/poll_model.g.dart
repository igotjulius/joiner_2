// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollModel _$PollModelFromJson(Map<String, dynamic> json) => PollModel(
      question: json['question'] as String?,
      choices: json['choices'] as List<dynamic>?,
    )..id = json['_id'] as String?;

Map<String, dynamic> _$PollModelToJson(PollModel instance) => <String, dynamic>{
      'question': instance.question,
      'choices': instance.choices,
    };
