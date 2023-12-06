import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/utils/image_handler.dart';
import 'package:joiner_1/utils/utils.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class AddCarModel extends FlutterFlowModel {
  /// Initialization and disposal methods.

  DateTimeRange? datePicked;
  PickedImages? imagePicker;
  bool? isSuccessful;

  // State field(s) for TextField widget.
  TextEditingController? licenseController;
  // State field(s) for TextField widget.
  TextEditingController? vehicleTypeController;
  // State field(s) for TextField widget.
  TextEditingController? datesController;
  // State field(s) for TextField widget.
  TextEditingController? priceController;

  void initState(BuildContext context) {}

  void dispose() {
    licenseController?.dispose();
    vehicleTypeController?.dispose();
    datesController?.dispose();
    priceController?.dispose();
    imagePicker = null;
  }

  /// Action blocks are added here.
  // Registering a car
  FutureBuilder<String?> registerCar() {
    final car = CarModel(
      licensePlate: licenseController.text,
      ownerId: FFAppState().currentUser!.id,
      ownerName:
          '${FFAppState().currentUser!.firstName} ${FFAppState().currentUser!.lastName}',
      vehicleType: vehicleTypeController.text,
      availability: 'Available',
      availableStartDate: datePicked!.start,
      availableEndDate: datePicked!.end,
      price: double.parse(priceController.text),
    );

    return FutureBuilder(
      future: CraController.registerCar(car, imagePicker!.getImages()!),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done)
          return CircularProgressIndicator();

        if (snapshot.data != null) {
          isSuccessful = false;
          return Column(
            children: [
              Image.asset(
                'assets/images/cancelled-payment.png',
                height: 60,
                width: 60,
              ),
              Text(
                'License plate submitted has already been registered to a car.',
                textAlign: TextAlign.center,
              ),
            ].divide(
              SizedBox(
                height: 8,
              ),
            ),
          );
        } else {
          isSuccessful = true;
          return Column(
            children: [
              Image.asset(
                'assets/images/successful-payment.png',
                height: 60,
                width: 60,
              ),
              Text(
                'Car registered into the system.',
                textAlign: TextAlign.center,
              ),
            ].divide(
              SizedBox(
                height: 8,
              ),
            ),
          );
        }
      },
    );
  }

  /// Additional helper methods are added here.
  /// Validators
  String? licenseValidator(String? value) {
    return isEmpty(value);
  }

  String? vehicleTypeValidator(String? value) {
    return isEmpty(value);
  }

  String? datesValidator(String? value) {
    return isEmpty(value);
  }

  String? priceValidator(String? value) {
    return isEmpty(value);
  }
}
