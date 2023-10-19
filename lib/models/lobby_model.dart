import 'package:json_annotation/json_annotation.dart';

part 'lobby_model.g.dart';

@JsonSerializable()
class LobbyModel {
  @JsonKey(
    name: '_id',
  )
  final String? id;
  final String? title;
  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<String>? participants;
  final Map<String, double>? budget;
  final String? conversation;

  const LobbyModel({
    this.id,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.participants,
    this.budget,
    this.conversation
  });

  factory LobbyModel.fromJson(Map<String, dynamic> json) =>
      _$LobbyModelFromJson(json);
  Map<String, dynamic> toJson() => _$LobbyModelToJson(this);
}
