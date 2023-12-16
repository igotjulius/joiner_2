import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:joiner_1/utils/generic_response.dart';
import 'package:joiner_1/widgets/atoms/user_rental_info.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class RentalsModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.
  FutureBuilder<ResponseModel<List<RentalModel>>> getRentals() {
    return FutureBuilder(
      future: UserController.getRentals(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        final result = snapshot.data!.data;
        return result == null
            ? Center(
                child: Text('Empty rentals'),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: result.length,
                itemBuilder: (context, index) {
                  RentalModel rental = result[index];
                  return RentalInfo(
                    rental: rental,
                  );
                },
              );
      },
    );
  }

  /// Additional helper methods are added here.
}
