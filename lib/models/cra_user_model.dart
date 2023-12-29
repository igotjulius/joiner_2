import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/models/helpers/user.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cra_user_model.g.dart';

@JsonSerializable()
class CraUserModel extends User {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(includeIfNull: false)
  String? contactNo, address;
  String firstName, lastName, email, password;
  List<CarModel> vehicles;
  List<RentalModel> rentals;

  CraUserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.contactNo,
    this.address,
    required this.vehicles,
    required this.rentals,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          contactNo: contactNo,
          address: address,
        );

  factory CraUserModel.fromJson(Map<String, dynamic> json) =>
      _$CraUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$CraUserModelToJson(this);

  // static List<CarModel> _fromJsonVehicles(List<dynamic> json) =>
  //     json.map((e) => CarModel.fromJson(e)).toList();
  // static List<RentalModel> _fromJsonRentals(List<dynamic> json) =>
  //     json.map((e) => RentalModel.fromJson(e)).toList();
}
