import 'package:json_annotation/json_annotation.dart';

part 'poll_model.g.dart';

@JsonSerializable()
class PollModel {
  @JsonKey(name: '_id', includeToJson: false)
  final String? id;
  final String? question;
  // toJson choices = List<String>, fromJson choices = List<Map<String, String>>
  final List<dynamic>? choices;
  final bool? isOpen;

  const PollModel({this.id, this.question, this.choices, this.isOpen});

  factory PollModel.fromJson(Map<String, dynamic> json) =>
      _$PollModelFromJson(json);
  Map<String, dynamic> toJson() => _$PollModelToJson(this);
}
