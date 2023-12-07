import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/utils/image_handler.dart';
import 'package:joiner_1/utils/utils.dart';

class EditCarModel extends FlutterFlowModel {
  CarModel? car;
  String? licensePlate;
  DateTimeRange? datePicked;
  String? availability;
  TextEditingController? datesController;
  TextEditingController? licenseController;
  TextEditingController? vehicleTypeController;
  TextEditingController? priceController;
  PickedImages? imagePicker;
  bool? isSuccessful;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  void initializeControllers() {
    availability = car!.isAvailable! ? 'Available' : 'Unavailable';
    licenseController ??= TextEditingController();
    licenseController!.text = car!.licensePlate!;
    vehicleTypeController ??= TextEditingController();
    vehicleTypeController!.text = car!.vehicleType!;
    priceController ??= TextEditingController();
    priceController!.text = car!.price.toString();
    datesController ??= TextEditingController();
    datesController!.text =
        '${DateFormat('MMM d').format(car!.startDate!)} - ${DateFormat('MMM d').format(car!.endDate!)}';
  }

  // Converts picked files to a MultipartFile for sending to the server
  Future<List<MultipartFile>> convert(List<PlatformFile> files) async {
    final multipartFiles = <MultipartFile>[];

    for (final file in files) {
      final fileBytes = file.bytes!;
      final multipartFile = MultipartFile.fromBytes(
        fileBytes,
        filename: file.name,
        contentType: MediaType('application', 'octet-stream'),
      );
      multipartFiles.add(multipartFile);
    }
    return multipartFiles;
  }

  FutureBuilder<String?> editCar() {
    if (datePicked == null) {
      datePicked = DateTimeRange(
        start: car!.startDate!,
        end: car!.endDate!,
      );
    }
    final uCar = CarModel(
      licensePlate: licenseController!.text,
      vehicleType: vehicleTypeController!.text,
      isAvailable: availability == 'Available' ? true : false,
      startDate: datePicked?.start,
      endDate: datePicked?.end,
      price: double.parse(priceController!.text),
    );

    return FutureBuilder(
      future: CraController.editCar(uCar, imagePicker!.getImages()),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done)
          return CircularProgressIndicator();

        isSuccessful = true;
        return Column(
          children: [
            Image.asset(
              'assets/images/successful-payment.png',
              height: 60,
              width: 60,
            ),
            Text(
              'Car details updated.',
              textAlign: TextAlign.center,
            ),
          ].divide(
            SizedBox(
              height: 8,
            ),
          ),
        );
      },
    );
  }

  Future<CarModel?> fetchCar() async {
    return await CraController.getCraCar(licensePlate!);
  }

  /// Validators
  String? licenseValidator(String? value) {
    return isEmpty(value);
  }

  String? vehicleTypeValidator(String? value) {
    return isEmpty(value);
  }

  String? datesValidator(String? value) {
    return isEmpty(value);
  }

  String? priceValidator(String? value) {
    return isEmpty(value);
  }
}
