import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/car_rental_model.dart';
import 'package:url_launcher/url_launcher.dart';

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
  }

  /// Action blocks are added here.
  void bookNow(String licensePlate, BuildContext context) {
    var redirect;
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Text('Click next to proceed to the payment page.'),
          actions: [
            TextButton(
              onPressed: () {
                UserController.postRental(
                  CarRentalModel(
                    licensePlate: licensePlate,
                    startRental: datePicked!.start.toString(),
                    endRental: datePicked!.end.toString(),
                    duration: datePicked!.duration.inDays,
                  ),
                ).then((value) {
                  redirect = value.data;
                  launchUrl(
                    Uri.parse(redirect!),
                    mode: LaunchMode.externalApplication,
                  );
                  context.goNamed('CarRentals');
                });
              },
              child: Text('Next'),
            ),
          ],
        );
      },
    );
  }

  /// Additional helper methods are added here.
}
