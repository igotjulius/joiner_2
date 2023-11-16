import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    CloseButton(
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ],
                ),
                Text('Register your Vehicle'),
                imagePicker(),
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
                datePicker(context),
                CustomTextInput(
                  label: 'Price',
                  controller: _model.priceController,
                  validator: _model.priceControllerValidator,
                  keyboardType: TextInputType.number,
                  inputFormatters: FilteringTextInputFormatter.digitsOnly,
                ),
                FilledButton(
                  onPressed: () {
                    _model.registerCar();
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
    );
  }

  Widget datePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Available Dates'),
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
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(width: 0.5),
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
        return Image.memory(image.bytes!);
      },
    );
  }
}
