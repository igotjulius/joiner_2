import 'package:joiner_1/models/participant_model.dart';
import 'package:joiner_1/models/poll_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lobby_model.g.dart';

@JsonSerializable()
class LobbyModel {
  @JsonKey(
    name: '_id',
    includeFromJson: true,
  )
  final String? id;
  final String? hostId;
  final String? title;
  final String? description;
  final String? destination;
  final String? meetingPlace;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<ParticipantModel>? participants;
  final Map<String, double>? budget;
  final List<PollModel>? poll;
  final String? conversation;

  const LobbyModel({
    this.id,
    this.hostId,
    this.title,
    this.description,
    this.destination,
    this.meetingPlace,
    this.startDate,
    this.endDate,
    this.participants,
    this.budget,
    this.poll,
    this.conversation,
  });

  factory LobbyModel.fromJson(Map<String, dynamic> json) =>
      _$LobbyModelFromJson(json);
  Map<String, dynamic> toJson() => _$LobbyModelToJson(this);
}
