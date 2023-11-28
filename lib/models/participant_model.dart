import 'package:json_annotation/json_annotation.dart';

part 'participant_model.g.dart';

@JsonSerializable()
class ParticipantModel {
  @JsonKey(
    name: '_id',
  )
  final String? id;
  final String? userId;
  final String? firstName;
  final String? lastName;
  final String? joinStatus;
  final Map<String, double>? contribution;
  final String? type;
  final List? pledges;

  const ParticipantModel({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.joinStatus,
    this.contribution,
    this.type,
    this.pledges,
  });

  factory ParticipantModel.fromJson(Map<String, dynamic> json) =>
      _$ParticipantModelFromJson(json);
  Map<String, dynamic> toJson() => _$ParticipantModelToJson(this);
}
