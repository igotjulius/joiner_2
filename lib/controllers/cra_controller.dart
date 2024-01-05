import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/index.dart';
import 'package:joiner_1/main.dart';
import 'package:joiner_1/models/cra_user_model.dart';
import 'package:joiner_1/models/helpers/user.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:joiner_1/pages/cra/car/add_car/add_car_widget.dart';
import 'package:joiner_1/pages/cra/car/cra_car_widget.dart';
import 'package:joiner_1/pages/cra/car/edit_car/edit_car_widget.dart';
import 'package:joiner_1/pages/shared_pages/rentals/rental_details/rental_details_widget.dart';
import 'package:joiner_1/service/api_service.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/car_model.dart';

class CraController extends Auth {
  CraController(this._currentUser, this._apiService);
  ApiService _apiService;
  CraUserModel _currentUser;
  late SharedPreferences _pref;
  final _craRoutes = [
    GoRoute(
      name: 'Cars',
      path: '/cars',
      builder: (context, params) => NavBarPage(
        initialPage: 'Cars',
        page: CraCarWidget(),
      ),
      routes: [
        GoRoute(
          name: 'RegisterCar',
          path: 'registerCar',
          builder: (context, state) => AddCarWidget(),
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: AddCarWidget(),
          ),
        ),
        GoRoute(
          name: 'CarDetails',
          path: ':licensePlate',
          builder: (context, state) {
            final obj = state.extra as CarModel;
            return EditCarWidget(car: obj);
          },
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: Builder(
              builder: (context) {
                final obj = state.extra as CarModel;
                return EditCarWidget(
                  car: obj,
                );
              },
            ),
          ),
        ),
      ],
    ),
    GoRoute(
      name: 'CraRentals',
      path: '/craRentals',
      builder: (context, params) => NavBarPage(
        initialPage: 'CraRentals',
        page: RentalsWidget(),
      ),
      routes: [
        GoRoute(
          name: 'RentalDetails',
          path: 'rentalDetails',
          builder: (context, state) {
            final RentalModel rental = state.extra as RentalModel;
            return RentalDetails(
              rental: rental,
            );
          },
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: Builder(
              builder: (context) {
                final RentalModel rental = state.extra as RentalModel;
                return RentalDetails(rental: rental);
              },
            ),
          ),
        ),
      ],
    ),
    GoRoute(
      name: 'Account',
      path: '/account',
      builder: (context, params) => NavBarPage(
        initialPage: 'Account',
        page: AccountWidget(),
      ),
    ),
  ];

  @override
  List<GoRoute> get routes => _craRoutes;

  @override
  User get profile => _currentUser;

  @override // TODO: implemented
  set profile(User? user) => _currentUser = user as CraUserModel;

  @override // TODO: implemented
  Future<bool> cacheUser() async {
    try {
      _pref = await SharedPreferences.getInstance();
      String craUser = jsonEncode(_currentUser.toJson());
      _pref.setString('craUser', craUser);
      return true;
    } catch (e, stack) {
      print('Error in caching user data: $e');
      print(stack);
    }
    return false;
  }

  List<CarModel> get cars => _currentUser.vehicles;

  // TODO: implemented
  void refetchCraCars() async {
    final res = await _apiService.getCraCars(_currentUser.id);
    _currentUser.vehicles = res.data ?? [];
    notifyListeners();
  }

  // Fetch a specific car
  CarModel? getCar(String licensePlate) {
    CarModel? car;
    cars.forEach((element) {
      if (element.licensePlate == licensePlate) {
        car = element;
        return;
      }
    });
    return car;
  }

  // Register car under corresponding CRA TODO: implemented
  Future<String?> registerCar(CarModel car, List<XFile> images) async {
    List<MultipartFile> converted = [];
    for (final image in images) {
      final multipartFile = MultipartFile.fromBytes(
        await image.readAsBytes(),
        filename: image.name,
        contentType: MediaType('application', 'octet-stream'),
      );
      converted.add(multipartFile);
    }
    final result = await _apiService.registerCar(
      _currentUser.id,
      licensePlate: car.licensePlate!,
      ownerId: car.ownerId!,
      ownerName: car.ownerName!,
      vehicleType: car.vehicleType,
      availability: car.availability,
      startDate: car.startDate.toString(),
      endDate: car.endDate.toString(),
      price: car.price,
      files: converted,
    );
    print(result.message);
    // Return error message if car is already registered by its licenseplate
    if (result.code == 406) return result.message;
    _currentUser.vehicles.add(result.data!);
    notifyListeners();
    return null;
  }

  // Edit car TODO: implemented
  Future<String?> editCar(CarModel car, List<XFile>? images) async {
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

    final result = await _apiService.editCar(
      _currentUser.id,
      car.licensePlate!,
      licensePlate: car.licensePlate!,
      vehicleType: car.vehicleType,
      availability: car.availability,
      startDate: car.startDate.toString(),
      endDate: car.endDate.toString(),
      price: car.price,
      files: converted,
    );

    // Return error message
    if (result.code == 406) return result.message;
    final index = _currentUser.vehicles
        .indexWhere((element) => element.licensePlate == car.licensePlate);
    _currentUser.vehicles[index] = result.data!;
    notifyListeners();
    return null;
  }

  // Delete a car
  Future<bool> removeCar(String licensePlate) async {
    final result = await _apiService.deleteCar(_currentUser.id, licensePlate);
    if (result.code == HttpStatus.ok) {
      _currentUser.vehicles
          .removeWhere((element) => element.licensePlate == licensePlate);
      notifyListeners();
      return true;
    }
    return false;
  }

  // Fetch CRA's rentals
  @override // TODO: implemented
  List<RentalModel> get rentals => _currentUser.rentals;

  @override // TODO: implemented
  void refetchRentals() async {
    try {
      final result = await _apiService.getCraRentals(_currentUser.id);
      _currentUser.rentals = result.data ?? [];
      cacheUser();
      notifyListeners();
    } catch (e, stack) {
      print('Error in fetching cra rentals: $e');
      print(stack);
    }
  }

  /*
    Account related actions
  */

  // Change Cra's password // TODO: implemented
  Future<bool> changePassword(String password, String newPassword) async {
    try {
      final result = await _apiService.changeCraPassword(
        {'password': password, 'newPassword': newPassword},
        _currentUser.id,
      );
      _currentUser.password = result.data!;
      notifyListeners();
      return true;
    } catch (e, stack) {
      print('Error in changing password: $e');
      print(stack);
    }
    return false;
  }

  // TODO: implemented
  @override
  Future<bool> logout() async {
    try {
      _pref = await SharedPreferences.getInstance();
      _pref.clear();
      return true;
    } catch (e, stack) {
      print('Error in logging out: $e');
      print(stack);
      throw e;
    }
  }

  @override // TODO: implemented
  Future<bool> editAccount(String firstName, String lastName) async {
    try {
      final result = await _apiService.editCraAccount(
          {'firstName': firstName, 'lastName': lastName}, _currentUser.id);
      if (result.code == HttpStatus.ok) {
        _currentUser.firstName = firstName;
        _currentUser.lastName = lastName;
        notifyListeners();
        return true;
      } else
        return false;
    } catch (e, stack) {
      print('Error in editting account: $e');
      print(stack);
    }
    return false;
  }
  /*

    -----End of Account relations-----

  */
}
