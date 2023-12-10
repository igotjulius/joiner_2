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
  String? imagePickerError;
  final _formKey = GlobalKey<FormState>();
  bool isEnabled = true;

  @override
  void initState() {
    super.initState();
    _model = EditCarModel(widget.car!);
    isEnabled = widget.car?.availability == 'On rent' ? false : true;
  }

  @override
  void dispose() {
    super.dispose();
    _model.dispose();
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
        actions: !isEnabled
            ? null
            : [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialogLoading(context);
                        _model.editCar().then(
                          (value) {
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
                            context.pop();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            info(),
            imagePicker(),
            Text(
              'License plate',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              _model.car!.licensePlate!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Row(
              children: [
                availability(),
                SizedBox(width: 20),
                vehicleType(),
              ],
            ),
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

  Widget displayPrice() {
    if (isEnabled) {
      return CustomTextInput(
        label: 'Price',
        controller: _model.priceController,
        validator: isEmpty,
      );
    } else {
      return Column(
        children: [
          Text(
            'Price',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Text(
            _model.car!.price.toString(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      );
    }
  }

  Widget info() {
    return Align(
      alignment: Alignment.center,
      child: InfoContainer(
        filled: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline_rounded,
              color: Theme.of(context).colorScheme.secondary,
            ),
            SizedBox(
              width: 4,
            ),
            Flexible(
              child: Text(
                isEnabled
                    ? 'Click the image if you want to upload new set of images.'
                    : 'Vehicles on rent can not be edited.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget availability() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Availability',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(height: 4),
        !isEnabled
            ? Text(
                _model.car!.availability!,
                style: Theme.of(context).textTheme.bodyLarge,
              )
            : DropdownMenu<String>(
                enabled: isEnabled,
                enableSearch: false,
                requestFocusOnTap: false,
                initialSelection: _model.availability,
                dropdownMenuEntries: <String>['Available', 'Unavailable']
                    .map((value) => DropdownMenuEntry<String>(
                          value: value,
                          label: value,
                        ))
                    .toList(),
                onSelected: (value) {
                  _model.availability = value;
                },
              ),
      ],
    );
  }

  Widget vehicleType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vehicle Type',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(height: 4),
        !isEnabled
            ? Text(
                _model.car!.vehicleType!,
                style: Theme.of(context).textTheme.bodyLarge,
              )
            : DropdownMenu<String>(
                enabled: isEnabled,
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
              ),
      ],
    );
  }

  Widget imagePicker() {
    return Column(
      children: [
        Card(
          child: InkWell(
            hoverColor: isEnabled ? null : Colors.transparent,
            onTap: !isEnabled
                ? null
                : () async {
                    imagePickerError = await _model.imagePicker!.selectImages();
                    setState(() {});
                  },
            child: imageCarousel(),
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

  Widget imageCarousel() {
    final images = _model.imagePicker!.getImages() != null
        ? _model.imagePicker!.getImages()
        : _model.car!.photoUrl;
    return CarouselSlider.builder(
      itemCount: images!.length,
      options: CarouselOptions(
        viewportFraction: 0.7,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
      ),
      itemBuilder: (context, index, viewIndex) {
        final image = images[index];
        return _model.imagePicker!.getImages() != null
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

  Widget datePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Available Dates',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        !isEnabled
            ? Text(
                '${DateFormat('MMM d').format(_model.datePicked!.start)} - ${DateFormat('MMM d').format(_model.datePicked!.end)}',
                style: Theme.of(context).textTheme.bodyLarge,
              )
            : InkWell(
                hoverColor: isEnabled ? null : Colors.transparent,
                onTap: !isEnabled
                    ? null
                    : () async {
                        _model.datePicked = await showDateRangePicker(
                          context: context,
                          firstDate: getCurrentTimestamp,
                          lastDate: DateTime(2050),
                        );

                        if (_model.datePicked != null) {
                          setState(() {
                            _model.datesController?.text =
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
                    key: ValueKey(_model.datesController?.text),
                    controller: _model.datesController,
                    validator: isEmpty,
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
}
