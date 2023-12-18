import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joiner_1/models/helpers/user.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:joiner_1/service/api_service.dart';
import 'package:http_parser/http_parser.dart';
import 'package:joiner_1/utils/generic_response.dart';
import '../models/car_model.dart';

class CraController {
  static late Map<String, String> user = {
    'userId': '',
  };

  // Register CRA
  static Future<String?> registerCra(User nUser) async {
    final result = await apiService.registerCra(nUser);
    if (result.code == HttpStatus.created) return null;
    return result.message;
  }

  // Get all registered cars of corresponding CRA
  static Future<List<CarModel>?> getCraCars() async {
    final res = await apiService.getCraCars(user['userId']!);
    return res.data;
  }

  // Fetch a specific car
  static Future<CarModel?> getCraCar(String licensePlate) async {
    final res = await apiService.getCraCar(user['userId']!, licensePlate);
    return res.data;
  }

  // Register car under corresponding CRA
  static Future<String?> registerCar(CarModel car, List<XFile> images) async {
    List<MultipartFile> converted = [];
    for (final image in images) {
      final multipartFile = MultipartFile.fromBytes(
        await image.readAsBytes(),
        filename: image.name,
        contentType: MediaType('application', 'octet-stream'),
      );
      converted.add(multipartFile);
    }
    final result = await apiService.registerCar(
      user['userId']!,
      licensePlate: car.licensePlate!,
      ownerId: car.ownerId!,
      ownerName: car.ownerName!,
      vehicleType: car.vehicleType!,
      availability: car.availability!,
      startDate: car.startDate!.toString(),
      endDate: car.endDate!.toString(),
      price: car.price!,
      files: converted,
    );
    // Return error message if car is already registered by its licenseplate
    if (result.code == 406) return result.message;

    return null;
  }

  // Edit car
  static Future<String?> editCar(CarModel car, List<XFile>? images) async {
    List<MultipartFile>? converted;
    if (images != null) {
      converted = [];
      for (final image in images) {
        final multipartFile = MultipartFile.fromBytes(
          await image.readAsBytes(),
          filename: image.name,
          contentType: MediaType('application', 'octet-stream'),
        );
        converted.add(multipartFile);
      }
    }

    final result = await apiService.editCar(
      user['userId']!,
      car.licensePlate!,
      licensePlate: car.licensePlate!,
      vehicleType: car.vehicleType!,
      availability: car.availability!,
      startDate: car.startDate!.toString(),
      endDate: car.endDate!.toString(),
      price: car.price!,
      files: converted,
    );

    // Return error message
    if (result.code == 406) return result.message;

    return null;
  }

  // Delete a car
  static Future<bool> deleteCar(String licensePlate) async {
    final result = await apiService.deleteCar(user['userId']!, licensePlate);
    return result.code == HttpStatus.ok ? true : false;
  }

  // Fetch CRA's rentals
  static Future<List<RentalModel>?> getCraRentals() async {
    final result = await apiService.getCraRentals(user['userId']!);
    return result.data;
  }

  // Edit Cra's account
  static Future<User?> editCraAccount(String firstName, String lastName) async {
    final result = await apiService.editCraAccount(
        user['userId']!, {'firstName': firstName, 'lastName': lastName});
    return result.data;
  }

  // Change Cra's password
  static Future<ResponseModel> changeCraPassword(
      String password, String newPassword) async {
    return await apiService.changeCraPassword(
        user['userId']!, {'password': password, 'newPassword': newPassword});
  }
}
