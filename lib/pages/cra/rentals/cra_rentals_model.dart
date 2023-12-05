import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:joiner_1/widgets/atoms/user_rental_info.dart';

class CraRentalsModel extends FlutterFlowModel {
  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  FutureBuilder<List<RentalModel>?> getCraRentals() {
    return FutureBuilder(
      future: CraController.getCraRentals(),
      builder: (context, snapshot) {
        final rentals = snapshot.data;
        if (rentals == null)
          return Center(
            child: Text('No rentals as of the moment'),
          );
        return SingleChildScrollView(
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (context, index) {
                  final rental = rentals[index];
                  return InkWell(
                    onTap: () {
                      context.pushNamed(
                        'RentalDetails',
                        extra: <String, dynamic>{
                          'rental': rental,
                        },
                      );
                    },
                    child: RentalInfo(
                      rental: rental,
                    ),
                  );
                },
                itemCount: rentals.length,
              ),
            ],
          ),
        );
      },
    );
  }
}
