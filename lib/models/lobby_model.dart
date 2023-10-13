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

  const LobbyModel({
    this.id,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.participants,
  });

  factory LobbyModel.fromJson(Map<String, dynamic> json) =>
      _$LobbyModelFromJson(json);
  Map<String, dynamic> toJson() => _$LobbyModelToJson(this);
}
