import 'dart:async';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/utils/utils.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class AddCarModel extends FlutterFlowModel {
  /// Initialization and disposal methods.

  DateTimeRange? datePicked;
  List<PlatformFile>? pickedFiles;

  // State field(s) for TextField widget.
  TextEditingController? licenseController;
  // State field(s) for TextField widget.
  TextEditingController? vehicleTypeController;
  // State field(s) for TextField widget.
  TextEditingController? datesController;
  // State field(s) for TextField widget.
  TextEditingController? priceController;

  void initState(BuildContext context) {}

  void dispose() {
    licenseController?.dispose();
    vehicleTypeController?.dispose();
    datesController?.dispose();
    priceController?.dispose();
  }

  /// Action blocks are added here.
  // Picking files, limits to only 3 images
  Future<String?> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
      withData: true,
    );
    if (result == null) return null;
    if (result.count > 5) {
      return 'You can only upload upto 5 images at most.';
    }
    pickedFiles = result.files;
    return null;
  }

  // Registering a car
  FutureBuilder<String?> registerCar() {
    final converted = convert(pickedFiles!);
    final car = CarModel(
      licensePlate: licenseController.text,
      ownerId: FFAppState().currentUser!.id,
      ownerName:
          '${FFAppState().currentUser!.firstName} ${FFAppState().currentUser!.lastName}',
      vehicleType: vehicleTypeController.text,
      availability: 'Available',
      availableStartDate: datePicked!.start,
      availableEndDate: datePicked!.end,
      price: double.parse(priceController.text),
    );
    return FutureBuilder(
      future: CraController.registerCar(car, converted),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done)
          return CircularProgressIndicator();

        if (snapshot.data != null)
          return Column(
            children: [
              Image.asset(
                'assets/images/cancelled-payment.png',
                height: 60,
                width: 60,
              ),
              Text(
                  'License plate submitted has already been registered to a car.'),
            ],
          );
        else
          return Column(
            children: [
              Image.asset(
                'assets/images/successful-payment.png',
                height: 60,
                width: 60,
              ),
              Text('Car registered into the system.')
            ].divide(
              SizedBox(
                height: 8,
              ),
            ),
          );
      },
    );
  }

  // Converts picked files to a MultipartFile for sending to the server
  List<MultipartFile> convert(List<PlatformFile> files) {
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

  /// Additional helper methods are added here.
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
