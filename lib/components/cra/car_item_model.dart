import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_model.dart';
import 'package:joiner_1/models/car_model.dart';

class CarItemModel extends FlutterFlowModel {
  TextEditingController? priceInput;
  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  void editCar(String licensePlate) async {
    var nCar = CarModel(
      availability: 'Available',
      price: double.parse(priceInput!.text),
    );
    CraController.editAvailability(nCar, licensePlate);
  }
}
