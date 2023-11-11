import 'dart:io';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';


class AddCarModel extends FlutterFlowModel {
  /// Initialization and disposal methods.

  DateTimeRange? datePicked;

  // State field(s) for TextField widget.
  TextEditingController? licenseController;
  String? Function(BuildContext, String?)? licenseControllerValidator;
  // State field(s) for TextField widget.
  TextEditingController? vehicleTypeController;
  String? Function(BuildContext, String?)? vehicleTypeControllerValidator;
  // State field(s) for TextField widget.
  TextEditingController? availabilityController;
  String? Function(BuildContext, String?)? availabilityControllerValidator;
  // State field(s) for TextField widget.
  TextEditingController? priceController;
  String? Function(BuildContext, String?)? priceControllerValidator;

  void initState(BuildContext context) {}

  void dispose() {
    licenseController?.dispose();
    vehicleTypeController?.dispose();
    availabilityController?.dispose();
    priceController?.dispose();
  }

  Future<String> uploadImage(File imageFile) async {
  String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  Reference storageReference =
      FirebaseStorage.instance.ref().child('images/$fileName');
  UploadTask uploadTask = storageReference.putFile(imageFile);
  await uploadTask.whenComplete(() => null);
  String imageUrl = await storageReference.getDownloadURL();
  return imageUrl;
}

Future<String> getImageUrl(String imageName) async {
  Reference storageReference =
      FirebaseStorage.instance.ref().child('images/$imageName');
  String imageUrl = await storageReference.getDownloadURL();
  return imageUrl;
}



  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
