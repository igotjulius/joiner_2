import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_model.dart';

class CarItemModel extends FlutterFlowModel {
  TextEditingController? priceInput;
  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    priceInput?.dispose();
  }

  void deleteCar(String licensePlate) async {
    await CraController.deleteCar(licensePlate);
  }
}
