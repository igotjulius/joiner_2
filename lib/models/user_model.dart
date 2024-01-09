import 'package:joiner_1/models/helpers/user.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(includeIfNull: false)
  final String? password;
  final String? firstName, lastName, email;
  final List<Map<String, String>>? friends;
  final List<RentalModel>? rentals;

  const UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.friends,
    this.rentals,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
        );
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
