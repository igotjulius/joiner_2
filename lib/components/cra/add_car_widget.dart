import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joiner_1/components/cra/add_car_model.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_widgets.dart';
import 'package:joiner_1/models/car_model.dart';
import '../../controllers/cra_controller.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../widgets/atoms/text_input.dart';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:image_picker_web/image_picker_web.dart';

class AddCarModal extends StatefulWidget {
  const AddCarModal({super.key});

  @override
  State<AddCarModal> createState() => _AddCarModalState();
}

class _AddCarModalState extends State<AddCarModal> {
  late AddCarModel _model;
  File? _selectedImage;
  String? _imageBytes;

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
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final uploadedFile = uploadInput.files!.first;
      final reader = html.FileReader();

      reader.readAsDataUrl(uploadedFile);

      reader.onLoadEnd.listen((loadEndEvent) {
        setState(() {
          _selectedImage = File(uploadedFile.name);
          _imageBytes = reader.result as String;
        });
      });
    });
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
                Text('Register your Vehicle'),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: _selectedImage != null
                        ? Image.memory(
                            base64.decode(_imageBytes!.split(',').last),
                            fit: BoxFit.cover,
                          )
                        : Icon(Icons.add_photo_alternate),
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
                      final car = CarModel(
                        licensePlate: _model.licenseController.text,
                        vehicleType: _model.vehicleTypeController.text,
                        availableStartDate: _model.datePicked!.start,
                        availableEndDate: _model.datePicked!.end,
                        price: double.parse(_model.priceController.text),
                      );
                      await CraController.addCar(car);
                      return Navigator.pop(context);
                    },
                    options: FFButtonOptions(height: 40.0)),
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
