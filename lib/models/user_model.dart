import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(
    includeFromJson: true,
    includeToJson: false,
    name: '_id',
  )
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final List<Map<String, String>>? friends;

  const UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.friends,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
