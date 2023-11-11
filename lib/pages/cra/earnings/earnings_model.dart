import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_model.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:joiner_1/widgets/atoms/cra_transaction_info.dart';

class EarningsModel extends FlutterFlowModel {
  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  FutureBuilder<List<RentalModel>> getCraRentals() {
    return FutureBuilder(
      future: CraController.getCraRentals(),
      builder: (context, snapshot) {
        List<RentalModel>? rentals = snapshot.data;
        if (rentals == null)
          return Center(
            child: Text('No rentals for this month'),
          );
        return ListView.builder(
          shrinkWrap: true,
          itemCount: rentals.length,
          itemBuilder: (context, index) {
            final rental = rentals[index];
            return InkWell(
              onTap: () {
                // TODO:
                // Go to Rental Details page
              },
              child: CraTransactionInfo(
                name: rental.renterName,
                date: rental.startRental.toString(),
                duration: rental.duration,
                amount: rental.price,
              ),
            );
          },
        );
      },
    );
  }
}
