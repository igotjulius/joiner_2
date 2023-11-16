import 'dart:async';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/models/car_model.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class AddCarModel extends FlutterFlowModel {
  /// Initialization and disposal methods.

  DateTimeRange? datePicked;
  List<PlatformFile>? pickedFiles;

  // State field(s) for TextField widget.
  TextEditingController? licenseController;
  String? Function(String?)? licenseControllerValidator;
  // State field(s) for TextField widget.
  TextEditingController? vehicleTypeController;
  String? Function(String?)? vehicleTypeControllerValidator;
  // State field(s) for TextField widget.
  TextEditingController? datesController;
  String? Function(String?)? datesControllerValidator;
  // State field(s) for TextField widget.
  TextEditingController? priceController;
  String? Function(String?)? priceControllerValidator;

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
    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);
    if (result == null) return null;
    if (result.count > 5) {
      return 'You can only upload upto 5 images at most.';
    }
    pickedFiles = result.files;
    return null;
  }

  // If environment is in testing
  Future<void> registerCar() async {
    final converted = await convert(pickedFiles!);
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
    await CraController.registerCar(car, converted);
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

  /// Additional helper methods are added here.
}
