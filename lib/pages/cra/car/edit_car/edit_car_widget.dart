import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/pages/cra/car/edit_car/edit_car_model.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:joiner_1/widgets/atoms/info_container.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';

class EditCarWidget extends StatefulWidget {
  final CarModel? car;
  const EditCarWidget({super.key, this.car});

  @override
  State<EditCarWidget> createState() => _EditCarWidgetState();
}

class _EditCarWidgetState extends State<EditCarWidget> {
  late EditCarModel _model;
  String? _imagePickerError;
  final _formKey = GlobalKey<FormState>();
  bool _isEnabled = true;

  @override
  void initState() {
    super.initState();
    _model = EditCarModel(widget.car!);
    _isEnabled = widget.car?.availability == 'On rent' ? false : true;
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text('Details'),
        actions: !_isEnabled
            ? null
            : [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialogLoading(context);
                        _model.editCar(context).then(
                          (value) {
                            context.pop();
                            if (value != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                showError(
                                    value, Theme.of(context).colorScheme.error),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                showSuccess('Changes saved'),
                              );
                            }
                          },
                        );
                      }
                    },
                    child: Text('Save changes'),
                  ),
                ),
              ],
      ),
      body: SingleChildScrollView(
        child: mainDisplay(),
      ),
    );
  }

  Widget mainDisplay() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            info(),
            imagePicker(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'License plate',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  _model.car.licensePlate!,
                ),
              ],
            ),
            availability(),
            vehicleType(),
            displayPrice(),
            datePicker(),
          ].divide(
            SizedBox(
              height: 10,
            ),
          ),
        ),
      ),
    );
  }

  Widget info() {
    return Align(
      alignment: Alignment.center,
      child: InfoContainer(
          filled: true,
          child: Text(
            _isEnabled
                ? 'Click the image if you want to upload new set of images.'
                : 'Vehicles on rent can not be edited.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          )),
    );
  }

  Widget availability() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Availability',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        !_isEnabled
            ? Text(
                _model.car.availability!,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              )
            : DropdownMenu<String>(
                enabled: _isEnabled,
                enableSearch: false,
                requestFocusOnTap: false,
                initialSelection: _model.car.availability,
                dropdownMenuEntries: <String>['Available', 'Unavailable']
                    .map((value) => DropdownMenuEntry<String>(
                          value: value,
                          label: value,
                        ))
                    .toList(),
                onSelected: (value) {
                  _model.availabilityController.text = value!;
                },
                inputDecorationTheme: InputDecorationTheme(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  constraints: BoxConstraints.tight(Size.fromHeight(40)),
                ),
                controller: _model.availabilityController,
              ),
      ],
    );
  }

  Widget vehicleType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Vehicle Type',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(height: 4),
        !_isEnabled
            ? Text(
                _model.car.vehicleType!,
              )
            : dropdownMenu(),
      ],
    );
  }

  Widget displayPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            'Price',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        _isEnabled
            ? Expanded(
                child: CustomTextInput(
                  controller: _model.priceController,
                  validator: isEmpty,
                  contentPadding: EdgeInsets.all(10),
                  isDense: true,
                ),
              )
            : Text(
                _model.car.price.toString(),
              ),
      ],
    );
  }

  Widget datePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            'Available Dates',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        !_isEnabled
            ? Text(
                '${DateFormat('MMM d').format(_model.datePicked!.start)} - ${DateFormat('MMM d').format(_model.datePicked!.end)}',
              )
            : Expanded(
                child: InkWell(
                  hoverColor: _isEnabled ? null : Colors.transparent,
                  onTap: !_isEnabled
                      ? null
                      : () async {
                          _model.datePicked = await showDateRangePicker(
                            context: context,
                            firstDate: getCurrentTimestamp,
                            lastDate: DateTime(2050),
                          );

                          if (_model.datePicked != null) {
                            setState(() {
                              _model.datesController.text =
                                  '${DateFormat('MMM d').format(_model.datePicked!.start)} - ${DateFormat('MMM d').format(_model.datePicked!.end)}';
                            });
                          }
                        },
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      inputDecorationTheme:
                          Theme.of(context).inputDecorationTheme.copyWith(
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                    ),
                    child: CustomTextInput(
                      key: ValueKey(_model.datesController.text),
                      controller: _model.datesController,
                      validator: _model.datesValidator,
                      prefixIcon: Icon(
                        Icons.calendar_today_rounded,
                        size: 20,
                      ),
                      enabled: false,
                      isDense: true,
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  Widget dropdownMenu() {
    return DropdownMenu<String>(
      enabled: _isEnabled,
      enableSearch: false,
      requestFocusOnTap: false,
      initialSelection: _model.vehicleType,
      dropdownMenuEntries: <String>['Sedan', 'Van', 'SUV']
          .map((value) => DropdownMenuEntry<String>(
                value: value,
                label: value,
              ))
          .toList(),
      onSelected: (value) {
        _model.vehicleType = value;
      },
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        constraints: BoxConstraints.tight(Size.fromHeight(40)),
      ),
    );
  }

  Widget imagePicker() {
    return Column(
      children: [
        Card(
          child: InkWell(
            hoverColor: _isEnabled ? null : Colors.transparent,
            onTap: !_isEnabled
                ? null
                : () async {
                    _imagePickerError = await _model.imagePicker.selectImages();
                    setState(() {});
                  },
            child: imageCarousel(),
          ),
        ),
        if (_imagePickerError != null)
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
                  _imagePickerError!,
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

  Widget imageCarousel() {
    final images = _model.imagePicker.getImages().isNotEmpty
        ? _model.imagePicker.getImages()
        : _model.car.photoUrl;
    return CarouselSlider.builder(
      itemCount: images!.length,
      options: CarouselOptions(
        viewportFraction: 0.7,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
      ),
      itemBuilder: (context, index, viewIndex) {
        final image = images[index];
        return _model.imagePicker.getImages().isNotEmpty
            ? pickedImage(image as XFile)
            : networkImage(image as String);
      },
    );
  }

  Widget pickedImage(XFile image) {
    if (kIsWeb) return Image.network(image.path);
    return Image.file(File(image.path));
  }

  Widget networkImage(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: getImageUrl(imageUrl),
      errorWidget: (context, url, error) => Icon(
        Icons.error,
        color: Colors.red,
      ),
      placeholder: (context, url) => Center(
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
