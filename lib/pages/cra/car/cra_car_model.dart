import 'package:flutter/material.dart';
import 'package:joiner_1/components/cra/car_item_widget.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/car_model.dart';

class CraCarModel extends FlutterFlowModel {
  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  FutureBuilder<List<CarModel>?> getCars() {
    return FutureBuilder(
        future: CraController.getCraCars(),
        builder: (context, snapshot) {
          List<CarModel>? cars = snapshot.data;
          if (cars == null)
            return Center(
              child: Text('No registered cars'),
            );

          return ListView.separated(
            itemCount: cars.length,
            itemBuilder: (context, index) {
              final car = cars[index];
              return CarItemWidget(car: car);
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 10, // Adjust the height of the separator as needed
                color:
                    Colors.white, // Adjust the color of the separator as needed
              );
            },
          );
        });
  }
}
