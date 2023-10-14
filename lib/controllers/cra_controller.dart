import 'package:flutter/material.dart';
import 'package:joiner_1/components/cra/car_item_widget.dart';
import 'package:joiner_1/service/api_service.dart';
import 'package:joiner_1/utils/generic_response.dart';

import '../models/car_model.dart';

class CraController {
  // Get all cars
  static FutureBuilder<ResponseModel<List<CarModel>>> getCars() {
    return FutureBuilder(
      future: apiService.getCars(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final cars = snapshot.data!.data!;
          double width = MediaQuery.of(context).size.width;
          return GridView.extent(
            crossAxisSpacing: 10,
            maxCrossAxisExtent: width / 2,
            children: List.generate(
              cars.length,
              (i) => CarItemWidget(car: cars[i]),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  static void addCar(CarModel car) async {
    await apiService.addCar(car).then((result) => print(result));
  }
}
