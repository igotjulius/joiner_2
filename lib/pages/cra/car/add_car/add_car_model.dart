// import 'package:joiner_1/models/car_model.dart';
// import 'package:joiner_1/utils/image_handler.dart';
// import 'package:joiner_1/utils/utils.dart';
// import '/flutter_flow/flutter_flow_util.dart';
// import 'package:flutter/material.dart';

// class AddCarModel {
//   DateTimeRange? datePicked;
//   PickedImages imagePicker = PickedImages();
//   TextEditingController licenseController = TextEditingController();
//   TextEditingController vehicleTypeController = TextEditingController();
//   TextEditingController datesController = TextEditingController();
//   TextEditingController priceController = TextEditingController();

//   void dispose() {
//     licenseController.dispose();
//     vehicleTypeController.dispose();
//     datesController.dispose();
//     priceController.dispose();
//   }

//   String? datesValidator(String? value) {
//     var validate = isEmpty(value);
//     if (validate != null) return validate;
//     if (datePicked!.duration.inDays < 1) return 'Minimum rent is one day';
//     return null;
//   }
// }
