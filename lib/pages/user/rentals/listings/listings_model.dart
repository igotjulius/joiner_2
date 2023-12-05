import 'package:joiner_1/components/user/car_item_widget.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/car_model.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';

class ListingsModel extends FlutterFlowModel {
  ///  Local state fields for this component.

  bool defaultRB = true;

  ///  State fields for stateful widgets in this component.

  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.
  FutureBuilder<List<CarModel>> getAvailableCars() {
    return FutureBuilder(
      future: UserController.getAvailableCars(),
      builder: (context, snapshot) {
        if (snapshot.data == null)
          return Center(
            child: Text('No available cars for today :('),
          );
        final cars = snapshot.data!;
        double width = MediaQuery.of(context).size.width / 2;
        return GridView.extent(
          shrinkWrap: true,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          maxCrossAxisExtent: width,
          children: List.generate(
            cars.length,
            (i) => CarItemWidget(car: cars[i]),
          ),
        );
      },
    );
  }

  /// Additional helper methods are added here.
}
