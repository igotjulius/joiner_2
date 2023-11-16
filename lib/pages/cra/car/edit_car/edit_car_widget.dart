import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/pages/cra/car/edit_car/edit_car_model.dart';
import 'package:joiner_1/utils/constants.dart';
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

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditCarModel());
    _model.licensePlate = widget.licensePlate;
    _model.car = widget.car;
    if (_model.car != null) _model.initializeControllers();
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
                _model.editCar();
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          info(),
          imagePicker(),
          availability(),
          CustomTextInput(
            label: 'License Plate',
            controller: _model.licenseController,
          ),
          CustomTextInput(
            label: 'Vehicle Type',
            controller: _model.vehicleTypeController,
          ),
          datePicker(context),
          CustomTextInput(
            label: 'Price',
            controller: _model.priceController,
          ),
        ].divide(
          SizedBox(
            height: 10,
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
              imagePickerError = await _model.pickImage();
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
    final images =
        _model.pickedFiles != null ? _model.pickedFiles : _model.car!.photoUrl;
    return CarouselSlider.builder(
      itemCount: images!.length,
      options: CarouselOptions(
        viewportFraction: 0.7,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
      ),
      itemBuilder: (context, index, viewIndex) {
        final image = images[index];
        return _model.pickedFiles != null
            ? pickedImage(image as PlatformFile)
            : networkImage(image as String);
      },
    );
  }

  Widget pickedImage(PlatformFile imageFile) {
    return Image.memory(imageFile.bytes!);
  }

  Widget networkImage(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: getImageUrl(_model.car!.ownerId!, imageUrl),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Available Dates'),
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
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                width: 0.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
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
                ),
              ].divide(SizedBox(width: 10.0)),
            ),
          ),
        ),
      ],
    );
  }
}
