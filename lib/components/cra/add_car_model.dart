import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class AddCarModel extends FlutterFlowModel {
  /// Initialization and disposal methods.

  DateTimeRange? datePicked;

  // State field(s) for TextField widget.
  TextEditingController? licenseController;
  String? Function(BuildContext, String?)? licenseControllerValidator;
  // State field(s) for TextField widget.
  TextEditingController? vehicleTypeController;
  String? Function(BuildContext, String?)? vehicleTypeControllerValidator;
  // State field(s) for TextField widget.
  TextEditingController? availabilityController;
  String? Function(BuildContext, String?)? availabilityControllerValidator;
  // State field(s) for TextField widget.
  TextEditingController? priceController;
  String? Function(BuildContext, String?)? priceControllerValidator;

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
