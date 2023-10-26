import 'package:joiner_1/models/helpers/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  @JsonKey(
    includeFromJson: true,
    includeToJson: false,
    name: '_id',
  )
  final String? id;
  final String? firstName, lastName, email;
  final List<Map<String, String>>? friends;

  const UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.friends,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          email: email,
        );
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
