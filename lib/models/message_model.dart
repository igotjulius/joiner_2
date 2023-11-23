import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  final String? creatorId;
  final String? creator;
  final String? message;
  final DateTime? createdAt;

  const MessageModel(
      {this.creatorId, this.creator, this.message, this.createdAt});

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
