
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
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
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];
  UploadTask? uploadTask;
  String? imageUrl;
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddCarModel());

    _model.licenseController ??= TextEditingController();
    _model.vehicleTypeController ??= TextEditingController();
    _model.availabilityController ??= TextEditingController();
    _model.priceController ??= TextEditingController();
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      setState(() {
        imageFileList.addAll(selectedImages);
      });
    }
  }

  Future<void> uploadImages() async {
    List<String> imagePaths = imageFileList.map((image) => image.path).toList();
    String userId = FFAppState().currentUser?.id.toString() ?? 'unknown_user';
    String licensePlate = _model.licenseController.text;

    List<String> downloadUrls = await uploadImagesToFirebase(imagePaths, userId, licensePlate);
  }

  Future<List<String>> uploadImagesToFirebase(List<String> imagePaths, String userId, String licensePlate) async {
    List<String> downloadUrls = [];

    try {
      FirebaseStorage storage = FirebaseStorage.instance;

      for (String imagePath in imagePaths) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        String path = 'images/$userId/$licensePlate/$fileName.png';

        Reference ref = storage.ref().child(path);
        File file = File(imagePath);

        final metadata = SettableMetadata(contentType: 'image/png');
        await ref.putFile(File(file.path), metadata);

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
                    Text('Register Car Rental Vehicle', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: imageFileList.isNotEmpty
                          ? GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemCount: imageFileList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.file(
                              File(imageFileList[index].path),
                              fit: BoxFit.fill,
                            ),
                          );
                        },
                      )
                          : Container(
                        child: Text(
                          'No Image/s Found',
                          style: TextStyle(color: Colors.grey),
                        ),
                        alignment: Alignment(0, 0),
                      ),
                    ),
                    SizedBox(height: 15),
                    MaterialButton(
                      onPressed: selectImages,
                      color: Colors.blue,
                      child: Text('Upload Images', style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(height: 25),
                    MaterialButton(
                      onPressed: () async {
                        if (imageFileList.isEmpty) {
                          Fluttertoast.showToast(
                            msg: 'Please select at least one image.',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.red, // Adjust the background color
                            textColor: Colors.white, // Adjust the text color
                            fontSize: 16.0,
                          );
                          return;
                        }
                        setState(() {
                          isUploading = true;
                        });

                        await uploadImages();

                        setState(() {
                          isUploading = false;
                        });

                        context.pop();
                      },
                      elevation: isUploading? 0 : 2,
                      color: isUploading? Colors.white : Colors.blue,
                      child: isUploading
                          ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      )
                          : Text('Upload To Firebase', style: TextStyle(color: Colors.white)),
                    ),
                  ],
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
                    //final imageUrl = await _uploadImage();
                    if (imageUrl == null) {
                      Fluttertoast.showToast(
                      msg: 'Please fill up all the fields',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red, // Adjust the background color
                      textColor: Colors.white, // Adjust the text color
                      fontSize: 16.0,
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
