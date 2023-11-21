import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/utils/image_handler.dart';
import 'package:joiner_1/utils/utils.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class AddCarModel extends FlutterFlowModel {
  /// Initialization and disposal methods.

  DateTimeRange? datePicked;
  PickedImages? imagePicker;
  bool? isSuccessful;

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
    imagePicker = null;
  }

  /// Action blocks are added here.
  // Registering a car
  FutureBuilder<String?> registerCar() {
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
      future: CraController.registerCar(car, imagePicker!.getImages()!),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done)
          return CircularProgressIndicator();

        if (snapshot.data != null) {
          isSuccessful = false;
          return Column(
            children: [
              Image.asset(
                'assets/images/cancelled-payment.png',
                height: 60,
                width: 60,
              ),
              Text(
                'License plate submitted has already been registered to a car.',
                textAlign: TextAlign.center,
              ),
            ].divide(
              SizedBox(
                height: 8,
              ),
            ),
          );
        } else {
          isSuccessful = true;
          return Column(
            children: [
              Image.asset(
                'assets/images/successful-payment.png',
                height: 60,
                width: 60,
              ),
              Text(
                'Car registered into the system.',
                textAlign: TextAlign.center,
              ),
            ].divide(
              SizedBox(
                height: 8,
              ),
            ),
          );
        }
      },
    );
  }
  /*
  Future<List<String>> uploadImages() async {
    List<XFile> images = imagePicker!.getImages()!;
    String userId = FFAppState().currentUser?.id.toString() ?? 'unknown_user';
    String licensePlate = licenseController.text;

    return await uploadImagesToFirebase(images, userId, licensePlate);
  }

  Future<List<String>> uploadImagesToFirebase(
      List<XFile> images, String userId, String licensePlate) async {
    List<String> downloadUrls = [];

    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      for (XFile imageFile in images) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        String path = 'images/cra/$userId/$licensePlate/$fileName.png';

        Reference ref = storage.ref().child(path);

        final metadata = SettableMetadata(
          contentType: 'image/png',
        );
        if (kIsWeb)
          await ref.putData(await imageFile.readAsBytes(), metadata);
        else
          await ref.putFile(File(imageFile.path), metadata);
        // await ref.putFile(imageFile, metadata);

        // Get the download URL for each uploaded image
        String downloadURL = await ref.getDownloadURL();
        downloadUrls.add(downloadURL);
        print('Image uploaded. Download URL: $downloadURL');
      }

      return downloadUrls;
    } catch (e) {
      print('Error uploading images: $e');
      return [];
    }
  }
  */

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
