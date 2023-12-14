import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joiner_1/utils/image_handler.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'car_booking_model.dart';
export 'car_booking_model.dart';

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

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CarBookingModel());

    _model.textController1 ??= TextEditingController();
    _model.textController2 ??= TextEditingController();
    _model.imagePicker = PickedImages();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Requirements for Rental',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: false,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          color: Color(0x28000000),
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'Please Upload any Government ID',
                            ),
                          ),
                          Center(
                            child: Container(
                              height: 200,
                              width: 300,
                              decoration: _model.brokenLines,
                              child: InkWell(
                                onTap: () async {
                                  await _model.imagePicker?.selectImage();
                                  setState(() {});
                                },
                                child: _model.imagePicker?.getImage() != null
                                    ? displayImage()
                                    : Center(
                                        child: Text('Tap to Upload'),
                                      ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 8,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(top: 30),
                            child: Text(
                              'Start Date - End Date of Rental',
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FlutterFlowIconButton(
                                borderRadius: 20,
                                borderWidth: 1,
                                buttonSize: 40,
                                icon: Icon(
                                  Icons.calendar_month,
                                  size: 24,
                                ),
                                onPressed: () async {
                                  final checkDate = DateTime.now()
                                      .isBefore(widget.car!.startDate!);
                                  showDateRangePicker(
                                    context: context,
                                    firstDate: checkDate
                                        ? widget.car!.startDate!
                                        : DateTime.now(),
                                    lastDate: widget.car!.endDate!,
                                  ).then((value) {
                                    if (value != null) {
                                      _model.datePicked = value;
                                      String start = DateFormat('yyyy-MM-dd')
                                          .format(value.start);
                                      String end = DateFormat('yyyy-MM-dd')
                                          .format(value.end);
                                      _model.textController2.text =
                                          start + " - " + end;
                                    }
                                  });
                                },
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8, 0, 8, 0),
                                  child: TextFormField(
                                    controller: _model.textController2,
                                    focusNode: _model.textFieldFocusNode2,
                                    autofocus: true,
                                    readOnly: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'yyyy-mm-dd - yyyy-mm-dd',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                            child: Text(
                              'Payment',
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                            child: Text(
                              'Pending Payment...',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              _model.bookNow(widget.car!.licensePlate!).then((isSuccess) {
                if (isSuccess) {
                  showSnackbar(context, 'Rental success');
                  context.goNamed('CarRentals');
                } else
                  showSnackbar(context, 'Rental failed');
              });
            },
            child: Container(
              width: double.infinity,
              height: 100,
              constraints: BoxConstraints(
                maxHeight: 70,
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor,
                    offset: Offset(0, -2),
                  )
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              alignment: AlignmentDirectional(0.00, -0.20),
              child: Text('Book Now',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget displayImage() {
    XFile image = _model.imagePicker!.getImage()!;
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
}
