import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(
    includeFromJson: true,
    includeToJson: false,
    name: '_id',
  )
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
