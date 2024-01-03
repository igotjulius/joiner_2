import 'dart:io';
import 'package:intl/intl.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joiner_1/models/car_rental_model.dart';
import 'package:joiner_1/utils/image_handler.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:joiner_1/widgets/atoms/info_container.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CarBookingWidget extends StatefulWidget {
  final CarModel car;
  const CarBookingWidget({super.key, required this.car});

  @override
  _CarBookingWidgetState createState() => _CarBookingWidgetState();
}

class _CarBookingWidgetState extends State<CarBookingWidget>
    with TickerProviderStateMixin {
  String? _noImage;
  final _formKey = GlobalKey<FormState>();
  DateTimeRange _datePicked =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  TimeOfDay? _pickUpTime;
  TimeOfDay? _returnTime;
  PickedImages _imagePicker = PickedImages();
  late TabController _tabController;
  TextEditingController _dates = TextEditingController();
  TextEditingController _pickUpTimeCtrl = TextEditingController();
  TextEditingController _returnTimeCtrl = TextEditingController();

  bool isSelectedDatesValid(
      List<Map<String, dynamic>> schedule, DateTime start, DateTime end) {
    for (var element in schedule) {
      // Parse date to DateTime object
      DateTime rentalStartDate = DateTime.parse(element['rentalStartDate']);
      DateTime rentalEndDate = DateTime.parse(element['rentalEndDate']);
      // Convert dates for comparing
      rentalStartDate = DateTime.utc(
          rentalStartDate.year, rentalStartDate.month, rentalStartDate.day);
      rentalEndDate = DateTime.utc(
          rentalEndDate.year, rentalEndDate.month, rentalEndDate.day);
      start = DateTime.utc(start.year, start.month, start.day);
      end = DateTime.utc(end.year, end.month, end.day);

      if (start.compareTo(rentalEndDate) <= 0 &&
          end.compareTo(rentalStartDate) >= 0) return false;
    }
    return true;
  }

  bool isSelectedTimeValid(TimeOfDay time) {
    if (6 < time.hour && time.hour < 18)
      return true;
    else
      return false;
  }

  Widget uploadId() {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Please Upload any Government ID',
            ),
            SizedBox(
              height: 300,
              width: 400,
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () async {
                    await _imagePicker.selectImage();
                    setState(() {
                      _noImage = null;
                    });
                  },
                  child: _imagePicker.getImage() != null
                      ? displayImage()
                      : Center(
                          child: Text('Tap to Upload'),
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
                          getCurrentTimestamp.isBefore(widget.car.startDate)
                              ? widget.car.startDate
                              : getCurrentTimestamp,
                      lastDate: getCurrentTimestamp.isAfter(widget.car.endDate)
                          ? getCurrentTimestamp
                          : widget.car.endDate,
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          _dates.text =
                              '${DateFormat('MMM d').format(value.start)} - ${DateFormat('MMM d').format(value.end)}';
                        });
                        _datePicked = value;
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
                      controller: _dates,
                      validator: (value) {
                        final isValid = isSelectedDatesValid(
                          widget.car.schedule!,
                          _datePicked.start,
                          _datePicked.end,
                        );
                        if (!isValid)
                          return 'Selected dates have already been rented';
                        return datesValidator(
                            value, _datePicked.duration.inDays);
                      },
                      suffixIcon: Icon(
                        Icons.calendar_today_rounded,
                      ),
                      enabled: false,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pick-up time',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(
                  height: 4,
                ),
                InkWell(
                  onTap: () async {
                    final value = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (value != null) {
                      setState(() {
                        _pickUpTimeCtrl.text = value.format(context);
                        _pickUpTime = value;
                      });
                    }
                  },
                  child: displayTimePicker(_pickUpTimeCtrl, _pickUpTime),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Return time',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(
                  height: 4,
                ),
                InkWell(
                  onTap: () async {
                    final value = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (value != null) {
                      setState(() {
                        _returnTimeCtrl.text = value.format(context);
                        _returnTime = value;
                      });
                    }
                  },
                  child: displayTimePicker(_returnTimeCtrl, _returnTime),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget displayTimePicker(
      TextEditingController controller, TimeOfDay? timePicked) {
    return CustomTextInput(
      suffixIcon: Icon(MdiIcons.clockOutline),
      controller: controller,
      enabled: false,
      validator: (value) {
        if (timePicked != null && !isSelectedTimeValid(timePicked)) {
          return 'Available time: 7 AM - 6 PM';
        }
        return isEmpty(value);
      },
    );
  }

  Widget displayImage() {
    XFile image = _imagePicker.getImage()!;
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
                details('Start date',
                    '${DateFormat('MMM d').format(_datePicked.start)}'),
                details('Pick-up time', _pickUpTime?.format(context) ?? ''),
                details('End date',
                    '${DateFormat('MMM d').format(_datePicked.end)}'),
                details('Return time', _returnTime?.format(context) ?? ''),
                details('Duration',
                    '${_datePicked.duration.inDays} day${_datePicked.duration.inDays > 1 ? 's' : ''}'),
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
                        '${_datePicked.duration.inDays * widget.car.price}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ].divide(
                SizedBox(
                  height: 8,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row details(String label, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.grey),
        ),
        Text(
          content,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget navButtons() {
    return Row(
      children: [
        if (_tabController.index != 0)
          TextButton(
            onPressed: () {
              _tabController.index--;
            },
            child: Text('Back'),
          ),
        Spacer(),
        FilledButton(
          child: Text('Next'),
          onPressed: () async {
            final startDateConverted = _datePicked.start.add(Duration(
                hours: _pickUpTime!.hour, minutes: _pickUpTime!.minute));
            final endDateConverted = _datePicked.end.add(Duration(
                hours: _returnTime!.hour, minutes: _returnTime!.minute));
            print(_datePicked.start.toUtc());
            if (_tabController.index == 1) {
              showDialogLoading(context);
              final rental = CarRentalModel(
                licensePlate: widget.car.licensePlate,
                startRental: startDateConverted.toString(),
                endRental: endDateConverted.toString(),
                duration: _datePicked.duration.inDays,
              );
              final redirUrl = await (context.read<Auth>() as UserController)
                  .postRental(rental, _imagePicker.getImage()!);
              await launchUrl(Uri.parse(redirUrl!),
                  mode: LaunchMode.externalApplication);
              context.pop();
            }
            if (_imagePicker.getImage() == null) {
              setState(() {
                _noImage = 'Please select an image of your valid ID';
              });
              return;
            }
            if (_tabController.index < 2 && _formKey.currentState != null) {
              setState(() {
                if (_formKey.currentState!.validate()) {
                  if (_noImage == null) _tabController.index++;
                }
              });
            }
          },
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _dates.dispose();
    super.dispose();
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
            Expanded(
              // fit: FlexFit.tight,
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
                    color: _tabController.index == 0
                        ? Theme.of(context).primaryColor
                        : Colors.grey[300],
                  ),
                ),
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _tabController.index == 1
                        ? Theme.of(context).primaryColor
                        : Colors.grey[300],
                  ),
                ),
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _tabController.index == 2
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
            navButtons(),
          ],
        ),
      ),
    );
  }
}
