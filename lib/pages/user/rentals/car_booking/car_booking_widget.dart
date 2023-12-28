import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joiner_1/models/car_rental_model.dart';
import 'package:joiner_1/utils/image_handler.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:joiner_1/widgets/atoms/info_container.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CarBookingWidget extends StatefulWidget {
  final CarModel? car;
  const CarBookingWidget({Key? key, this.car}) : super(key: key);

  @override
  _CarBookingWidgetState createState() => _CarBookingWidgetState();
}

PlatformFile? pickedFile;

class _CarBookingWidgetState extends State<CarBookingWidget>
    with TickerProviderStateMixin {
  late CarBookingModel _model;
  TabController? _tabController;
  String? _noImage;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _model = CarBookingModel();
    _tabController ??= TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController?.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Widget uploadId() {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Please Upload any Government ID',
        ),
        Expanded(
          child: SizedBox(
            height: 300,
            width: 300,
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () async {
                  await _model.imagePicker.selectImage();
                  setState(() {
                    _noImage = null;
                  });
                },
                child: _model.imagePicker.getImage() != null
                    ? displayImage()
                    : Center(
                        child: Text('Tap to Upload'),
                      ),
              ),
            ),
          ),
        ),
        if (_noImage != null)
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              _noImage!,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.error),
            ),
          ),
        SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pick dates',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(
              height: 4,
            ),
            InkWell(
              onTap: () async {
                showDateRangePicker(
                  context: context,
                  firstDate:
                      getCurrentTimestamp.isBefore(widget.car!.startDate!)
                          ? widget.car!.startDate!
                          : getCurrentTimestamp,
                  lastDate: getCurrentTimestamp.isAfter(widget.car!.endDate!)
                      ? getCurrentTimestamp
                      : widget.car!.endDate!,
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      _model.dates.text =
                          '${DateFormat('MMM d').format(value.start)} - ${DateFormat('MMM d').format(value.end)}';
                    });
                    _model.datePicked = value;
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
                child: Form(
                  key: _formKey,
                  child: CustomTextInput(
                    controller: _model.dates,
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
        ),
      ],
    );
  }

  Widget displayImage() {
    XFile image = _model.imagePicker.getImage()!;
    if (kIsWeb) {
      return Image.network(
        image.path,
      );
    } else {
      return Image.file(
        File(image.path),
      );
    }
  }

  Widget additionalDetails() {
    return Column(
      children: [
        InfoContainer(
          filled: true,
          child: Text(
            'Click next to proceed to the payment page',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Start Date',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.grey),
                    ),
                    Text(
                      '${DateFormat('MMM d').format(_model.datePicked.start)}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'End Date',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.grey),
                    ),
                    Text(
                      '${DateFormat('MMM d').format(_model.datePicked.end)}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Duration',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.grey),
                    ),
                    Text(
                      '${_model.datePicked.duration.inDays} day${_model.datePicked.duration.inDays > 1 ? 's' : ''}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.grey),
                    ),
                    withCurrency(
                      Text(
                        '${_model.datePicked.duration.inDays * widget.car!.price!}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget navButtons() {
    return Row(
      children: [
        if (_tabController?.index != 0)
          TextButton(
            onPressed: () {
              _tabController?.index--;
            },
            child: Text('Back'),
          ),
        Spacer(),
        FilledButton(
          onPressed: () async {
            if (_tabController?.index == 1) {
              try {
                showDialogLoading(context);
                final redirUrl =
                    await _model.processPayment(widget.car!.licensePlate!);
                print(redirUrl);
                await launchUrl(Uri.parse(redirUrl!),
                    mode: LaunchMode.externalApplication);
                context.pop();
              } catch (e) {
                print(e);
              }

              return;
            }
            if (_model.imagePicker.getImage() == null)
              _noImage = 'Please select an image of your valid ID';

            setState(() {
              if (_formKey.currentState!.validate()) {
                if (_noImage == null) _tabController?.index++;
              }
            });
          },
          child: Text('Next'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Requirements',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: TabBarView(
                controller: _tabController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  uploadId(),
                  additionalDetails(),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _tabController?.index == 0
                        ? Theme.of(context).primaryColor
                        : Colors.grey[300],
                  ),
                ),
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _tabController?.index == 1
                        ? Theme.of(context).primaryColor
                        : Colors.grey[300],
                  ),
                ),
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _tabController?.index == 2
                        ? Theme.of(context).primaryColor
                        : Colors.grey[300],
                  ),
                ),
              ].divide(
                SizedBox(
                  width: 4,
                ),
              ),
            ),
            Expanded(child: navButtons()),
          ],
        ),
      ),
    );
  }
}

class CarBookingModel {
  DateTimeRange datePicked =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  PickedImages imagePicker = PickedImages();
  TextEditingController dates = TextEditingController();

  /// Initialization and disposal methods.

  void dispose() {
    dates.dispose();
  }

  /// Action blocks are added here.
  Future<String?> processPayment(String licensePlate) async {
    final rental = CarRentalModel(
      licensePlate: licensePlate,
      startRental: datePicked.start.toString(),
      endRental: datePicked.end.toString(),
      duration: datePicked.duration.inDays,
    );
    // final result = await UserController.postRental(
    //   rental,
    //   imagePicker.getImage()!,
    // );
    // return result.data;
  }

  /// Additional helper methods are added here.
  String? datesValidator(String? value) {
    var validate = isEmpty(value);
    if (validate != null) return validate;
    if (datePicked.duration.inDays < 1)
      return 'Minimum rent duration is one day';
    return null;
  }
}
