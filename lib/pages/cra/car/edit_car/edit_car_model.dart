import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/utils/image_handler.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:provider/provider.dart';

class EditCarModel {
  CarModel car;
  DateTimeRange? datePicked;
  String? vehicleType;
  TextEditingController datesController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController availabilityController = TextEditingController();
  PickedImages imagePicker = PickedImages();

  EditCarModel(this.car) {
    vehicleType = car.vehicleType;
    priceController.text = car.price.toString();
    datesController.text =
        '${DateFormat('MMM d').format(car.startDate)} - ${DateFormat('MMM d').format(car.endDate)}';
    datePicked = DateTimeRange(start: car.startDate, end: car.endDate);
    imagePicker = PickedImages();
  }

  void dispose() {
    datesController.dispose();
    priceController.dispose();
    availabilityController.dispose();
  }

  Future<String?> editCar(BuildContext context) async {
    if (datePicked == null) {
      datePicked = DateTimeRange(
        start: car.startDate,
        end: car.endDate,
      );
    }
    final uCar = CarModel(
      licensePlate: car.licensePlate!,
      vehicleType: vehicleType!,
      availability: availabilityController.text,
      startDate: datePicked!.start,
      endDate: datePicked!.end,
      price: double.parse(priceController.text),
    );
    return (context.read<Auth>() as CraController)
        .editCar(uCar, imagePicker.getImages());
  }

  String? datesValidator(String? value) {
    var validate = isEmpty(value);
    if (validate != null) return validate;
    if (datePicked!.duration.inDays < 1) return 'Minimum rent is one day';
    return null;
  }
}
