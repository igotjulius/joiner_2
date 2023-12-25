import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/utils/image_handler.dart';
import 'package:joiner_1/utils/utils.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class AddCarModel {
  /// Initialization and disposal methods.
  DateTimeRange? datePicked;
  PickedImages imagePicker = PickedImages();

  // State field(s) for TextField widget.
  TextEditingController licenseController = TextEditingController();
  // State field(s) for TextField widget.
  TextEditingController vehicleTypeController = TextEditingController();
  // State field(s) for TextField widget.
  TextEditingController datesController = TextEditingController();
  // State field(s) for TextField widget.
  TextEditingController priceController = TextEditingController();

  void dispose() {
    licenseController.dispose();
    vehicleTypeController.dispose();
    datesController.dispose();
    priceController.dispose();
  }

  /// Action blocks are added here.
  // Registering a car
  Future<String?> register() async {
    final car = CarModel(
      licensePlate: licenseController.text,
      ownerId: FFAppState().currentUser!.id,
      ownerName:
          '${FFAppState().currentUser!.firstName} ${FFAppState().currentUser!.lastName}',
      vehicleType: vehicleTypeController.text,
      availability: 'Available',
      startDate: datePicked?.start,
      endDate: datePicked?.end,
      price: double.parse(priceController.text),
    );
    return await CraController.registerCar(car, imagePicker.getImages());
  }

  /// Additional helper methods are added here.
  /// Validators

  String? datesValidator(String? value) {
    var validate = isEmpty(value);
    if (validate != null) return validate;
    if (datePicked!.duration.inDays < 1) return 'Minimum rent is one day';
    return null;
  }
}
