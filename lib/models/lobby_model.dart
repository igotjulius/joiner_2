import 'package:joiner_1/models/expense_model.dart';
import 'package:joiner_1/models/participant_model.dart';
import 'package:joiner_1/models/poll_model.dart';
import 'package:joiner_1/models/rental_model.dart';
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
  String title;
  String? destination;
  DateTime? startDate;
  DateTime? endDate;
  List<ParticipantModel>? participants;
  final String? conversation;
  final List<PollModel>? poll;
  ExpenseModel? expense;
  final List<RentalModel>? linkedRental;

  LobbyModel({
    this.id,
    this.hostId,
    required this.title,
    this.destination,
    this.startDate,
    this.endDate,
    this.participants,
    this.poll,
    this.conversation,
    this.expense,
    this.linkedRental,
  });

  factory LobbyModel.fromJson(Map<String, dynamic> json) =>
      _$LobbyModelFromJson(json);
  Map<String, dynamic> toJson() => _$LobbyModelToJson(this);
}
