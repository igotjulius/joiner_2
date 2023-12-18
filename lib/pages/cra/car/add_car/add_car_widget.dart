import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:joiner_1/pages/cra/car/add_car/add_car_model.dart';
import 'package:joiner_1/utils/image_handler.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';

class AddCarWidget extends StatefulWidget {
  final AddCarModel? model;
  const AddCarWidget({super.key, this.model});

  @override
  State<AddCarWidget> createState() => _AddCarWidgetState(model);
}

class _AddCarWidgetState extends State<AddCarWidget> {
  _AddCarWidgetState(AddCarModel? model) {
    _model = model ?? AddCarModel();
  }
  late AddCarModel _model;
  String? imagePickerError;
  String? imageUrl;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _model.licenseController ??= TextEditingController();
    _model.vehicleTypeController ??= TextEditingController();
    _model.datesController ??= TextEditingController();
    _model.priceController ??= TextEditingController();
    _model.imagePicker = PickedImages();
  }

  @override
  void dispose() {
    super.dispose();
    _model.dispose();
  }

  Widget datePicker() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Available Dates',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () async {
              showDateRangePicker(
                context: context,
                firstDate: getCurrentTimestamp,
                lastDate: DateTime(2050),
              ).then((value) {
                if (value != null) {
                  setState(() {
                    _model.datesController?.text =
                        '${DateFormat('MMM d').format(value.start)} - ${DateFormat('MMM d').format(value.end)}';
                  });
                }
              });
            },
            child: Theme(
              data: Theme.of(context).copyWith(
                inputDecorationTheme:
                    Theme.of(context).inputDecorationTheme.copyWith(
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
              ),
              child: CustomTextInput(
                controller: _model.datesController,
                validator: _model.datesValidator,
                suffixIcon: Icon(
                  Icons.calendar_today_rounded,
                ),
                enabled: false,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget imagePicker() {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              imagePickerError = await _model.imagePicker!.selectImages();
              setState(() {});
            },
            child: Container(
              height: 160,
              child: _model.imagePicker!.getImages() != null &&
                      _model.imagePicker!.getImages()!.isNotEmpty
                  ? imageCarousel()
                  : Center(
                      child: Text(
                        'Tap to Upload Image',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
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
      ),
    );
  }

  CarouselSlider imageCarousel() {
    return CarouselSlider.builder(
      itemCount: _model.imagePicker!.getImages()!.length,
      options: CarouselOptions(
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
      ),
      itemBuilder: (context, index, viewIndex) {
        XFile image = _model.imagePicker!.getImages()![index];
        if (kIsWeb) {
          return Image.network(image.path);
        } else {
          return Image.file(
            File(image.path),
            fit: BoxFit.contain,
          );
        }
      },
    );
  }

  Widget price() {
    return CustomTextInput(
      label: 'Price',
      labelStyle:
          Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
      controller: _model.priceController,
      validator: _model.priceValidator,
      keyboardType: TextInputType.number,
      inputFormatters: FilteringTextInputFormatter.digitsOnly,
      direction: TextInputDirection.row,
    );
  }

  Widget licensePlate() {
    return CustomTextInput(
      label: 'License Plate',
      labelStyle:
          Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
      controller: _model.licenseController,
      validator: _model.licenseValidator,
      direction: TextInputDirection.row,
    );
  }

  Widget vehicleType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            'Vehicle Type',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey),
          ),
        ),
        Expanded(
          child: DropdownMenu<String>(
            key: Key('vehicleType'),
            enableSearch: false,
            requestFocusOnTap: false,
            dropdownMenuEntries: <String>['Sedan', 'Van', 'SUV']
                .map((value) => DropdownMenuEntry<String>(
                      value: value,
                      label: value,
                    ))
                .toList(),
            onSelected: (value) {
              // _model.vehicleType = value;
            },
            expandedInsets: EdgeInsets.zero,
          ),
        ),
      ],
    );
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
                  Column(
                    children: [
                      licensePlate(),
                      vehicleType(),
                      datePicker(),
                      price(),
                    ].divide(
                      SizedBox(
                        height: 10,
                      ),
                    ),
                  ),
                  FilledButton(
                    key: Key('submit'),
                    onPressed: () async {
                      // if (_formKey.currentState!.validate() &&
                      //     _model.imagePicker!.getImages() != null) {
                      // showDialogLoading(context);
                      // _model.register().then((value) {
                      //   if (value != null) {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       showError(
                      //           value, Theme.of(context).colorScheme.error),
                      //     );
                      //   } else {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       showSuccess('Car registered successfully'),
                      //     );
                      //   }
                      //   context.pop();
                      // });
                      // }
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          showSuccess('Car registered successfully'),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          showError('Registration failed', Colors.red),
                        );
                      }
                      imagePickerError =
                          _model.imagePicker!.getImages() == null ||
                                  _model.imagePicker!.getImages()!.isEmpty
                              ? 'Please upload an image of your car'
                              : null;
                      setState(() {});
                    },
                    child: Text('Register Car'),
                  ),
                ].divide(
                  SizedBox(
                    height: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
