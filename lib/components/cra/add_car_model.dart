import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class AddCarModel extends FlutterFlowModel {
  /// Initialization and disposal methods.

  DateTimeRange? datePicked;

  // State field(s) for TextField widget.
  TextEditingController? licenseController;
  String? Function(String?)? licenseControllerValidator;
  // State field(s) for TextField widget.
  TextEditingController? vehicleTypeController;
  String? Function(String?)? vehicleTypeControllerValidator;
  // State field(s) for TextField widget.
  TextEditingController? availabilityController;
  String? Function(String?)? availabilityControllerValidator;
  // State field(s) for TextField widget.
  TextEditingController? priceController;
  String? Function(String?)? priceControllerValidator;

  void initState(BuildContext context) {}

  void dispose() {
    licenseController?.dispose();
    vehicleTypeController?.dispose();
    availabilityController?.dispose();
    priceController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
