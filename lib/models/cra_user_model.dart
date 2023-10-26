import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/models/helpers/user.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cra_user_model.g.dart';

@JsonSerializable()
class CraUserModel extends User {
  @JsonKey(name: '_id')
  final String? id;
  final String? firstName, lastName, email;
  final List<CarModel>? vehicles;
  final List<RentalModel>? rentals;

  const CraUserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.vehicles,
    this.rentals,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          email: email,
        );

  factory CraUserModel.fromJson(Map<String, dynamic> json) =>
      _$CraUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$CraUserModelToJson(this);
}
