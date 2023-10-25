import 'package:flutter/cupertino.dart';
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

  FutureBuilder<List<CarModel>> getCars() {
    return FutureBuilder(
        future: CraController.getCraCars(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          List<CarModel>? cars = snapshot.data;
          if (cars == null)
            return Center(
              child: Text('No registered cars'),
            );
          double width = MediaQuery.of(context).size.width;
          return GridView.extent(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            maxCrossAxisExtent: width / 2,
            children: List.generate(
              cars.length,
              (i) => CarItemWidget(car: cars[i]),
            ),
          );
        });
  }
}
