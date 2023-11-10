import 'package:json_annotation/json_annotation.dart';

part 'participant_model.g.dart';

@JsonSerializable()
class ParticipantModel {
  @JsonKey(
    name: '_id',
  )
  final String? id;
  final String? userId;
  final String? name;
  final String? joinStatus;
  final String? type;
  final List? pledges;

  const ParticipantModel({
    this.id,
    this.userId,
    this.name,
    this.joinStatus,
    this.type,
    this.pledges,
  });

  factory ParticipantModel.fromJson(Map<String, dynamic> json) =>
      _$ParticipantModelFromJson(json);
  Map<String, dynamic> toJson() => _$ParticipantModelToJson(this);
}
