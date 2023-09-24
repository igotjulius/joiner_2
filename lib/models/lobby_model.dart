import 'package:json_annotation/json_annotation.dart';

part 'lobby_model.g.dart';

@JsonSerializable()
class LobbyModel {
  @JsonKey(
    name: '_id',
  )
  String? id;
  String? title;
  String? plannedDate;
  List<String>? participants;

  LobbyModel({
    this.id,
    this.title,
    this.plannedDate,
    this.participants,
  });

  factory LobbyModel.fromJson(Map<String, dynamic> json) =>
      _$LobbyModelFromJson(json);
  Map<String, dynamic> toJson() => _$LobbyModelToJson(this);
}
