import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_model.dart';
import 'package:joiner_1/models/car_model.dart';

class EditCarModel extends FlutterFlowModel {
  CarModel? car;
  String? licensePlate;
  DateTimeRange? datePicked;
  String? availability;
  TextEditingController? datesController;
  TextEditingController? licenseController;
  TextEditingController? vehicleTypeController;
  TextEditingController? priceController;
  List<PlatformFile>? pickedFiles;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  void initializeControllers() {
    datesController ??= TextEditingController();
    availability ??= car!.availability;
    licenseController ??= TextEditingController();
    licenseController!.text = car!.licensePlate!;
    vehicleTypeController ??= TextEditingController();
    vehicleTypeController!.text = car!.vehicleType!;
    priceController ??= TextEditingController();
    priceController!.text = car!.price.toString();
    datePicked = DateTimeRange(
      start: car!.availableStartDate!,
      end: car!.availableEndDate!,
    );
  }

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

  Future<void> editCar() async {
    final car = CarModel(
      licensePlate: licenseController!.text,
      vehicleType: vehicleTypeController!.text,
      availability: availability,
      availableStartDate: datePicked?.start,
      availableEndDate: datePicked?.end,
      price: double.parse(priceController!.text),
    );
    final converted = pickedFiles == null ? null : await convert(pickedFiles!);
    await CraController.editCar(car, converted);
  }

  Future<CarModel?> fetchCar() async {
    return await CraController.getCraCar(licensePlate!);
  }
}
