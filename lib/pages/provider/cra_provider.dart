import 'package:flutter/material.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/models/cra_user_model.dart';

class CraProvider extends ChangeNotifier {
  CraProvider(this._craUser);
  CraUserModel _craUser;
  CraUserModel get craUser => _craUser;
  void setCraUser(CraUserModel user) {
    _craUser = user;
  }

  List<CarModel>? get vehicles => _craUser.vehicles;
  void addCar(CarModel nCar) {
    _craUser.vehicles?.add(nCar);
    notifyListeners();
  }

  void removeCar(CarModel car) {
    _craUser.vehicles
        ?.removeWhere((element) => element.licensePlate == car.licensePlate);
    notifyListeners();
  }
}
