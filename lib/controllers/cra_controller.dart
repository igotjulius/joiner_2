import 'dart:io';
import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/helpers/user.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:joiner_1/service/api_service.dart';
import 'package:joiner_1/utils/generic_response.dart';
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
  static Future<List<CarModel>> getCraCars() async {
    final res = await apiService.getCraCars(_craUserId);
    return res.data!;
  }

  // Register car under corresponding CRA
  static Future<void> addCar(CarModel car) async {
    await apiService.addCar(car, _craUserId).then((result) => print(result));
  }

  // Edit car availability
  static FutureBuilder<ResponseModel> editAvailability(
      CarModel car, String licensePlate) {
    return FutureBuilder(
        future: apiService.editAvailability(car, licensePlate),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Dialog(
              child: Center(
                child: Text(snapshot.data!.message!),
              ),
            );
          } else {
            return Dialog(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  // Fetch CRA's rentals
  static Future<List<RentalModel>> getCraRentals() async {
    final res = await apiService.getCraRentals(_craUserId);
    return res.data!;
  }
}
