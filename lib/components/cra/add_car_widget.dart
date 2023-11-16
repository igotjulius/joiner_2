
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:joiner_1/components/cra/add_car_model.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_widgets.dart';
import 'package:joiner_1/models/car_model.dart';
import '../../controllers/cra_controller.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../widgets/atoms/text_input.dart';

class AddCarModal extends StatefulWidget {
  const AddCarModal({super.key});

  @override
  State<AddCarModal> createState() => _AddCarModalState();
}

class _AddCarModalState extends State<AddCarModal> {
  late AddCarModel _model;
  PlatformFile? pickedImage;
  UploadTask? uploadTask;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddCarModel());

    _model.licenseController ??= TextEditingController();
    _model.vehicleTypeController ??= TextEditingController();
    _model.availabilityController ??= TextEditingController();
    _model.priceController ??= TextEditingController();
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result == null) return;

    setState(() {
      pickedImage = result.files.first;
    });
  }

  Future<String?> _uploadImage() async {
    try {
      if (pickedImage == null || pickedImage!.path == null) {
        print("Error: Picked image or bytes are null");
        return null;
      }

      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final path = 'images/$fileName.png';

      final ref = FirebaseStorage.instance.ref().child(path);
      final metadata = SettableMetadata(contentType: 'image/png');
      await ref.putFile(File(pickedImage!.path!), metadata); // Use putFile here

      return await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    CloseButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Text('Register your Vehicle'),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: // FOR FLUTTER WEB
                    /*pickedImage != null && pickedImage!.bytes != null
                        ? Image.memory(pickedImage!.bytes!,
                            width: double.infinity, fit: BoxFit.fill)*/

                    // FOR FLUTTER MOBILE
                    pickedImage != null
                        ? Image.file(
                              File(pickedImage!.path!),
                              width: double.infinity,
                              fit: BoxFit.fill)
                        : Container(
                            child: Text(
                              'Tap to Upload Image',
                              style: TextStyle(color: Colors.grey),
                            ),
                            alignment: Alignment(0, 0),
                          ),
                  ),
                ),
                CustomTextInput(
                  label: 'License Plate',
                  controller: _model.licenseController,
                  validator: _model.licenseControllerValidator,
                ),
                CustomTextInput(
                  label: 'Vehicle Type',
                  controller: _model.vehicleTypeController,
                  validator: _model.vehicleTypeControllerValidator,
                ),
                InkWell(
                  onTap: () async {
                    _model.datePicked = await showDateRangePicker(
                      context: context,
                      firstDate: getCurrentTimestamp,
                      lastDate: DateTime(2050),
                    );
                    if (_model.datePicked != null)
                      setState(() {
                        _model.availabilityController.text =
                            '${DateFormat('MMM d').format(_model.datePicked!.start)} - ${DateFormat('MMM d').format(_model.datePicked!.end)}';
                      });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: Color(0xff9c9c9c),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          child: Icon(
                            Icons.calendar_today,
                            color: Color(0xFF52B2FA),
                            size: 24.0,
                          ),
                        ),
                        Text(
                          _model.datePicked != null
                              ? (_model.datePicked!.duration.inDays == 0
                                  ? "${DateFormat('MMM d').format(_model.datePicked!.start)}"
                                  : "${DateFormat('MMM d').format(_model.datePicked!.start)} - ${DateFormat('MMM d').format(_model.datePicked!.end)}")
                              : '',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Roboto Flex',
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ].divide(SizedBox(width: 10.0)),
                    ),
                  ),
                ),
                CustomTextInput(
                  label: 'Price',
                  controller: _model.priceController,
                  validator: _model.priceControllerValidator,
                  keyboardType: TextInputType.number,
                  inputFormatters: FilteringTextInputFormatter.digitsOnly,
                ),
                FFButtonWidget(
                  text: 'Register Car',
                  onPressed: () async {
                    final imageUrl = await _uploadImage();
                    if (imageUrl == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Image Error'),
                        ),
                      );
                      return;
                    }

                    final car = CarModel(
                      licensePlate: _model.licenseController.text,
                      vehicleType: _model.vehicleTypeController.text,
                      availableStartDate: _model.datePicked!.start,
                      availableEndDate: _model.datePicked!.end,
                      price: double.parse(_model.priceController.text),
                      photoUrl: imageUrl,
                    );

                    await CraController.addCar(car);
                    Navigator.pop(context);
                  },
                  options: FFButtonOptions(height: 40.0),
                ),
              ].divide(
                SizedBox(
                  height: 10,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
