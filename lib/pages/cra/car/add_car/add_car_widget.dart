import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/pages/cra/car/add_car/add_car_model.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';

class AddCarWidget extends StatefulWidget {
  const AddCarWidget({super.key});

  @override
  State<AddCarWidget> createState() => _AddCarWidgetState();
}

class _AddCarWidgetState extends State<AddCarWidget> {
  late AddCarModel _model;
  String? imagePickerError;
  UploadTask? uploadTask;
  String? imageUrl;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddCarModel());

    _model.licenseController ??= TextEditingController();
    _model.vehicleTypeController ??= TextEditingController();
    _model.datesController ??= TextEditingController();
    _model.priceController ??= TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register car'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  imagePicker(),
                  CustomTextInput(
                    label: 'License Plate',
                    controller: _model.licenseController,
                    validator: _model.licenseValidator,
                  ),
                  CustomTextInput(
                    label: 'Vehicle Type',
                    controller: _model.vehicleTypeController,
                    validator: _model.vehicleTypeValidator,
                  ),
                  datePicker(context),
                  CustomTextInput(
                    label: 'Price',
                    controller: _model.priceController,
                    validator: _model.priceValidator,
                    keyboardType: TextInputType.number,
                    inputFormatters: FilteringTextInputFormatter.digitsOnly,
                  ),
                  FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          _model.pickedFiles != null) {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Container(
                                height: 400,
                                width: 400,
                                child: Center(
                                  child: _model.registerCar(),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      imagePickerError = _model.pickedFiles == null
                          ? 'Please upload an image of your car'
                          : null;

                      setState(() {});
                    },
                    child: Text('Register Car'),
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
      ),
    );
  }

  Widget datePicker(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text('Available Dates'),
        ),
        SizedBox(
          height: 4,
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
                _model.datesController.text =
                    '${DateFormat('MMM d').format(_model.datePicked!.start)} - ${DateFormat('MMM d').format(_model.datePicked!.end)}';
              });
          },
          child: Theme(
            data: Theme.of(context).copyWith(
              // inputDecorationTheme: InputDecorationTheme(
              //   disabledBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.black)),
              // ),
              inputDecorationTheme:
                  Theme.of(context).inputDecorationTheme.copyWith(
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
            ),
            child: CustomTextInput(
              controller: _model.datesController,
              validator: _model.datesValidator,
              prefixIcon: Icon(
                Icons.calendar_today_rounded,
              ),
              enabled: false,
            ),
          ),
        ),
      ],
    );
  }

  Widget imagePicker() {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            imagePickerError = await _model.pickImage();
            setState(() {});
          },
          child: _model.pickedFiles != null
              ? imageCarousel()
              : Container(
                  height: 400,
                  child: Text(
                    'Tap to Upload Image',
                    style: TextStyle(color: Colors.grey),
                  ),
                  alignment: Alignment(0, 0),
                ),
        ),
        if (imagePickerError != null)
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error,
                  color: Theme.of(context).colorScheme.error,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  imagePickerError!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.error,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
      ],
    );
  }

  CarouselSlider imageCarousel() {
    return CarouselSlider.builder(
      itemCount: _model.pickedFiles?.length,
      options: CarouselOptions(
        height: 400,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
      ),
      itemBuilder: (context, index, viewIndex) {
        final image = _model.pickedFiles![index];
        if (kIsWeb) {
          return Image.memory(image.bytes!);
        }
        return Image.file(File(image.path!));
      },
    );
  }
}
