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
  String firstName, lastName, email, password, contactNo, address;
  List<LobbyModel> pendingLobby;
  List<LobbyModel> activeLobby;
  List<FriendModel> friends;
  List<RentalModel> rentals;
  final Map<String, dynamic>? verification;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.address,
    required this.contactNo,
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
          address: address,
          contactNo: contactNo,
          password: password,
          verification: verification,
        );
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
