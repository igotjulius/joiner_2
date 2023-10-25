import 'dart:io';
import 'package:flutter/material.dart';
import 'package:joiner_1/components/cra/car_item_widget.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/user_model.dart';
import 'package:joiner_1/service/api_service.dart';
import 'package:joiner_1/utils/generic_response.dart';
import '../models/car_model.dart';

class CraController {
  static late String _craUserId;

  // Login CRA
  static Future<UserModel?> loginCra(
      String email, String password, FFAppState appState) async {
    UserModel? user;
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
  static FutureBuilder<ResponseModel<List<CarModel>>> getCars() {
    return FutureBuilder(
      future: apiService.getCars(_craUserId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.data!.isEmpty)
            return Center(
              child: Text('No available cars for today :('),
            );
          final cars = snapshot.data!.data!;
          double width = MediaQuery.of(context).size.width;
          return GridView.extent(
            crossAxisSpacing: 10,
            maxCrossAxisExtent: width / 2,
            children: List.generate(
              cars.length,
              (i) => CarItemWidget(car: cars[i]),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // Register car under corresponding CRA
  static Future<void> addCar(CarModel car) async {
    await apiService.addCar(car, _craUserId).then((result) => print(result));
  }

  // Edit car availability
  static FutureBuilder<ResponseModel> editAvailability(String licensePlate) {
    return FutureBuilder(
        future: apiService.editAvailability(licensePlate),
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
}
