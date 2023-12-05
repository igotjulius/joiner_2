import 'dart:io';

import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/car_rental_model.dart';
import 'package:joiner_1/utils/image_handler.dart';

class CarBookingModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  DateTimeRange? datePicked;
  PickedImages? imagePicker;

  BorderSide borderSide = BorderSide(color: Colors.black, width: 1.0);
  BoxDecoration brokenLines = BoxDecoration(
    border: Border.all(color: Colors.grey, width: 1.0),
  );

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();
    imagePicker = null;
  }

  /// Action blocks are added here.
  Future<bool> bookNow(String licensePlate) async {
    final rental = CarRentalModel(
      licensePlate: licensePlate,
      startRental: datePicked!.start.toString(),
      endRental: datePicked!.end.toString(),
      duration: datePicked!.duration.inDays,
    );
    final result = await UserController.postRental(
      rental,
      imagePicker!.getImage()!,
    );
    return result.code == HttpStatus.ok ? true : false;
  }

  /// Additional helper methods are added here.
}
