import 'package:json_annotation/json_annotation.dart';

part 'friend_model.g.dart';

@JsonSerializable()
class FriendModel {
  final String friendId;
  final String firstName;
  final String lastName;
  String status;

  FriendModel({
    required this.friendId,
    required this.firstName,
    required this.lastName,
    required this.status,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) =>
      _$FriendModelFromJson(json);
  Map<String, dynamic> toJson() => _$FriendModelToJson(this);
}
