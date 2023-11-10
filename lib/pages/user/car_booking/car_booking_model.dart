import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/car_rental_model.dart';

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

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }

  /// Action blocks are added here.
  void bookNow(String licensePlate, BuildContext context) {
    var redirect;
    UserController.postRental(
      CarRentalModel(
          licensePlate: licensePlate,
          startRental: datePicked!.start.toString(),
          endRental: datePicked!.end.toString(),
          duration: datePicked!.duration.inDays),
    ).then((value) {
      redirect = value.data;
      launchURL(redirect!);
      context.pushNamed('CarRentals');
    });
  }

  /// Additional helper methods are added here.
}
