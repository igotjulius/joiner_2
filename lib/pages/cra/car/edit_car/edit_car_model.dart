import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/utils/image_handler.dart';

class EditCarModel {
  CarModel? car;
  DateTimeRange? datePicked;
  String? availability;
  String? vehicleType;
  TextEditingController? datesController;
  TextEditingController? priceController;
  PickedImages? imagePicker;

  EditCarModel(CarModel _car) {
    this.car = _car;
    availability =
        car?.availability == 'Available' ? 'Available' : 'Unavailable';
    vehicleType = car?.vehicleType;
    priceController ??= TextEditingController();
    priceController?.text = car!.price.toString();
    datesController ??= TextEditingController();
    datesController?.text =
        '${DateFormat('MMM d').format(car!.startDate!)} - ${DateFormat('MMM d').format(car!.endDate!)}';
    datePicked = DateTimeRange(start: car!.startDate!, end: car!.endDate!);
    imagePicker = PickedImages();
  }

  void dispose() {
    datesController?.dispose();
    priceController?.dispose();
    imagePicker = null;
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

  Future<String?> editCar() async {
    if (datePicked == null) {
      datePicked = DateTimeRange(
        start: car!.startDate!,
        end: car!.endDate!,
      );
    }
    final uCar = CarModel(
      licensePlate: car!.licensePlate!,
      vehicleType: vehicleType,
      availability: availability,
      startDate: datePicked?.start,
      endDate: datePicked?.end,
      price: double.parse(priceController!.text),
    );

    return await CraController.editCar(uCar, imagePicker!.getImages());
  }
}
