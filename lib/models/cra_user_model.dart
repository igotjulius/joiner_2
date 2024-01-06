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
  String firstName, lastName, email, password, contactNo, address;
  List<CarModel> vehicles;
  List<RentalModel> rentals;
  final Map<String, dynamic>? verification;

  CraUserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.contactNo,
    required this.address,
    required this.vehicles,
    required this.rentals,
    this.verification,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          contactNo: contactNo,
          address: address,
          verification: verification,
        );

  factory CraUserModel.fromJson(Map<String, dynamic> json) =>
      _$CraUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$CraUserModelToJson(this);

  // static List<CarModel> _fromJsonVehicles(List<dynamic> json) =>
  //     json.map((e) => CarModel.fromJson(e)).toList();
  // static List<RentalModel> _fromJsonRentals(List<dynamic> json) =>
  //     json.map((e) => RentalModel.fromJson(e)).toList();
}
