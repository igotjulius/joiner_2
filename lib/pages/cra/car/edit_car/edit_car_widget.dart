import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/pages/cra/car/edit_car/edit_car_model.dart';
import 'package:joiner_1/utils/image_handler.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:joiner_1/widgets/atoms/info_container.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';

class EditCarWidget extends StatefulWidget {
  final CarModel? car;
  final String? licensePlate;
  const EditCarWidget({super.key, this.car, this.licensePlate});

  @override
  State<EditCarWidget> createState() => _EditCarWidgetState();
}

class _EditCarWidgetState extends State<EditCarWidget> {
  late EditCarModel _model;
  String? imagePickerError;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditCarModel());
    _model.licensePlate = widget.licensePlate;
    _model.car = widget.car;
    if (_model.car != null) _model.initializeControllers();
    _model.imagePicker = PickedImages();
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        contentPadding: EdgeInsets.all(20),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_model.isSuccessful == null) _model.editCar(),
                          ],
                        ),
                        actions: [
                          FilledButton(
                            onPressed: () async {
                              if (_model.isSuccessful!) {
                                await CachedNetworkImage.evictFromCache(
                                    getImageUrl(widget.car!.photoUrl![0]));
                                context.goNamed('Cars');
                              }
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
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
        child: widget.car != null ? mainDisplay(context) : fetchCar(),
      ),
    );
  }

  Widget mainDisplay(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            info(),
            imagePicker(),
            availability(),
            CustomTextInput(
              label: 'License Plate',
              controller: _model.licenseController,
              validator: _model.licenseValidator,
              enabled: false,
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
            ),
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
                'Click the image if you want to upload new set of images.',
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Availability'),
            DropdownMenu<String>(
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
        ),
      ],
    );
  }

  FutureBuilder<CarModel?> fetchCar() {
    return FutureBuilder(
      future: _model.fetchCar(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        _model.car = snapshot.data;
        _model.initializeControllers();
        return mainDisplay(context);
      },
    );
  }

  Widget imagePicker() {
    return Column(
      children: [
        Card(
          child: InkWell(
            onTap: () async {
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
              ),
              enabled: false,
            ),
          ),
        ),
      ],
    );
  }
}
