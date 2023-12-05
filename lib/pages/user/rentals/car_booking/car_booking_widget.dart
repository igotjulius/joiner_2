import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:joiner_1/models/car_model.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }
  void unselectFile() {
    setState(() {
      pickedFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    double result = double.parse('${widget.car!.price! * (_model.datePicked?.duration.inDays ?? 0)}');

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
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
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

                    child: Stack(
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom:8.0),
                                child: Text(
                                  'Please Upload any Government ID',
                                ),
                              ),
                              Center(
                                child: Container(
                                  height: 200,
                                  width: 300,
                                  decoration: _model.brokenLines,
                                  child: Stack(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          await selectFile();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: pickedFile != null
                                              ? Image.file(
                                            File(pickedFile!.path!),
                                            fit: BoxFit.fill,
                                            width: double.infinity,
                                          )
                                              : Center(child: Text('Tap to Upload')),
                                        ),
                                      ),
                                      if (pickedFile != null)
                                        Positioned(
                                          top: 8.0,
                                          right: 8.0,
                                          child: IconButton(
                                            color: Colors.black,
                                            icon: Icon(Icons.close),
                                            onPressed: () {
                                              unselectFile();
                                            },
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Rental Date',
                                      ),
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
                                          setState(() {});
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4),
                                          border: Border.all(
                                            color: Color(0xff9c9c9c),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12, horizontal: 10),
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
                                                  : 'Start Date - End Date',
                                            ),
                                          ].divide(SizedBox(width: 10.0)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                                child: Text(
                                  'Payment',
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 0, 0),
                                child:
                                Text(
                                  NumberFormat.currency(
                                    symbol: '₱',
                                    decimalDigits: 2,
                                  ).format(result),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              _model.bookNow(widget.car!.licensePlate!, context);
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
              child: Text(
                'Book Now',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.white)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
