import 'dart:io';
import 'package:dio/dio.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/helpers/user.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:joiner_1/service/api_service.dart';
import '../models/car_model.dart';

class CraController {
  static late String _craUserId = FFAppState().pref!.getString('userId')!;

  // Register CRA
  static Future<void> registerCra(Map<String, String> nUser) async {
    await apiService.registerCra(nUser);
  }

  // Login CRA
  static Future<User?> loginCra(
      String email, String password, FFAppState appState) async {
    User? user;
    await apiService.loginCra({'email': email, 'password': password}).then(
      (response) {
        if (response.code == HttpStatus.ok) {
          user = response.data!;
          _craUserId = user!.id!;
        }
      },
    );
    return user;
  }

  // Get all registered cars of corresponding CRA
  static Future<List<CarModel>?> getCraCars() async {
    final res = await apiService.getCraCars(_craUserId);
    return res.data;
  }

  // Fetch a specific car
  static Future<CarModel?> getCraCar(String licensePlate) async {
    final res = await apiService.getCraCar(_craUserId, licensePlate);
    return res.data;
  }

  // Register car under corresponding CRA - (for online environment)
  static Future<void> addCar(CarModel car) async {
    await apiService.addCar(car, _craUserId).then((result) => print(result));
  }

  // Register car under corresponding CRA - (for offline environment)
  static Future<String?> registerCar(
      CarModel car, List<MultipartFile>? images) async {
    final result = await apiService.registerCar(
      _craUserId,
      licensePlate: car.licensePlate!,
      ownerId: car.ownerId!,
      ownerName: car.ownerName!,
      vehicleType: car.vehicleType!,
      availability: car.availability!,
      availableStartDate: car.availableStartDate.toString(),
      availableEndDate: car.availableEndDate.toString(),
      price: car.price!,
      files: images,
    );
    // Return error message if car is already registered by its licenseplate
    if (result.code == 406) return result.message;

    return null;
  }

  // Edit car availability
  static Future<void> editAvailability(
      CarModel car, String licensePlate) async {
    await apiService.editAvailability(car, _craUserId, licensePlate);
  }

  // Edit car
  static Future<void> editCar(CarModel car, List<MultipartFile>? images) async {
    await apiService.editCar(
      _craUserId,
      car.licensePlate!,
      licensePlate: car.licensePlate!,
      vehicleType: car.vehicleType!,
      availability: car.availability!,
      availableStartDate: car.availableStartDate.toString(),
      availableEndDate: car.availableEndDate.toString(),
      price: car.price!,
      files: images,
    );
  }

  // Delete a car
  static Future<void> deleteCar(String licensePlate) async {
    await apiService.deleteCar(_craUserId, licensePlate);
  }

  // Fetch CRA's rentals
  static Future<List<RentalModel>?> getCraRentals() async {
    final res = await apiService.getCraRentals(_craUserId);
    return res.data;
  }
}
