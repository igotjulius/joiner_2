import 'package:joiner_1/models/friend_model.dart';
import 'package:joiner_1/models/helpers/user.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(includeIfNull: false)
  String? password;
  String? firstName, lastName, email, contactNo;
  List<LobbyModel> pendingLobby;
  List<LobbyModel> activeLobby;
  List<FriendModel> friends;
  List<RentalModel> rentals;
  Map<String, String>? verification;

  UserModel({
    required this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.contactNo,
    required this.friends,
    required this.pendingLobby,
    required this.activeLobby,
    required this.rentals,
    this.verification,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          verification: verification,
        );
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
