import 'package:joiner_1/models/transaction_model.dart';
import 'package:joiner_1/service/api_service.dart';

import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'rent_car_model.dart';
export 'rent_car_model.dart';

class RentCarWidget extends StatefulWidget {
  const RentCarWidget({Key? key}) : super(key: key);

  @override
  _RentCarWidgetState createState() => _RentCarWidgetState();
}

class _RentCarWidgetState extends State<RentCarWidget> {
  late RentCarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RentCarModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Rent a Car',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Open Sans',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/car.png',
                        width: 114.0,
                        height: 80.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sedan',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Roboto Flex',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        Text(
                          '4-seater',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Open Sans',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ],
                    ),
                  ].divide(SizedBox(width: 10.0)),
                ),
                ToggleIcon(
                  onPressed: () async {
                    setState(() => _model.defaultRB = !_model.defaultRB);
                  },
                  value: _model.defaultRB,
                  onIcon: Icon(
                    Icons.radio_button_checked,
                    color: FlutterFlowTheme.of(context).primary,
                    size: 25.0,
                  ),
                  offIcon: Icon(
                    Icons.radio_button_off,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 25.0,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1.0,
            color: Color(0xFFDADADA),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/van.png',
                        width: 114.0,
                        height: 80.0,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Van',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Roboto Flex',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        Text(
                          '15-seater',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Open Sans',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ],
                    ),
                  ].divide(SizedBox(width: 10.0)),
                ),
                ToggleIcon(
                  onPressed: () async {
                    setState(() => _model.defaultRB = !_model.defaultRB);
                  },
                  value: !_model.defaultRB,
                  onIcon: Icon(
                    Icons.radio_button_checked,
                    color: FlutterFlowTheme.of(context).primary,
                    size: 25.0,
                  ),
                  offIcon: Icon(
                    Icons.radio_button_off,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 25.0,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1.0,
            color: Color(0xFFDADADA),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Trip to Lambug Beach',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Roboto Flex',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'Destination',
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                        ),
                        FlutterFlowDropDown<String>(
                          controller: _model.dropDownValueController1 ??=
                              FormFieldController<String>(
                            _model.dropDownValue1 ??= 'Badian City, Cebu',
                          ),
                          options: ['Badian City, Cebu'],
                          onChanged: (val) =>
                              setState(() => _model.dropDownValue1 = val),
                          width: 200.0,
                          height: 48.0,
                          textStyle:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Roboto Flex',
                                    color: FlutterFlowTheme.of(context).accent4,
                                  ),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xFF52B2FA),
                            size: 24.0,
                          ),
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          elevation: 2.0,
                          borderColor: FlutterFlowTheme.of(context).primary,
                          borderWidth: 1.0,
                          borderRadius: 8.0,
                          margin: EdgeInsetsDirectional.fromSTEB(
                              16.0, 4.0, 16.0, 4.0),
                          hidesUnderline: true,
                          isSearchable: false,
                          isMultiSelect: false,
                        ),
                      ].divide(SizedBox(width: 10.0)),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Text(
                            'Pickup & Return point',
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: FlutterFlowDropDown<String>(
                            controller: _model.dropDownValueController2 ??=
                                FormFieldController<String>(
                              _model.dropDownValue2 ??= 'Mandaue City, Cebu',
                            ),
                            options: ['Mandaue City, Cebu'],
                            onChanged: (val) =>
                                setState(() => _model.dropDownValue2 = val),
                            width: 200.0,
                            height: 48.0,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Roboto Flex',
                                  color: FlutterFlowTheme.of(context).accent4,
                                ),
                            icon: Icon(
                              Icons.search,
                              color: Color(0xFF52B2FA),
                              size: 16.0,
                            ),
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            elevation: 2.0,
                            borderColor: FlutterFlowTheme.of(context).primary,
                            borderWidth: 1.0,
                            borderRadius: 8.0,
                            margin: EdgeInsetsDirectional.fromSTEB(
                                16.0, 4.0, 16.0, 4.0),
                            hidesUnderline: true,
                            isSearchable: false,
                            isMultiSelect: false,
                          ),
                        ),
                      ].divide(SizedBox(width: 10.0)),
                    ),
                  ),
                ].divide(SizedBox(height: 10.0)),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1.0, -1.0),
                          child: Text(
                            'RENTAL DETAILS',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Open Sans',
                                  color: FlutterFlowTheme.of(context).accent4,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        Divider(
                          height: 6.0,
                          thickness: 1.0,
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primary,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    4.0, 4.0, 4.0, 4.0),
                                child: Icon(
                                  Icons.calendar_month,
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  size: 28.0,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Jul 30 - 8:00 AM',
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                ),
                                Text(
                                  'Jul 30 - 8:00 PM',
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              ].divide(SizedBox(height: 10.0)),
                            ),
                          ].divide(SizedBox(width: 10.0)),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Edit',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto Flex',
                                    color: FlutterFlowTheme.of(context).primary,
                                  ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 24.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      height: 6.0,
                      thickness: 1.0,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ].divide(SizedBox(height: 10.0)),
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      // return _addTransaction();
                      return Placeholder();
                    },
                  );
                },
                text: 'CONTINUE',
                options: FFButtonOptions(
                  height: 40.0,
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Open Sans',
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                  elevation: 3.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ].divide(SizedBox(height: 20.0)),
          ),
        ]
            .divide(SizedBox(height: 10.0))
            .addToStart(SizedBox(height: 20.0))
            .addToEnd(SizedBox(height: 20.0)),
      ),
    );
  }

  // FutureBuilder _addTransaction() {
  //   final nTransaction = TransactionModel(
  //     roomId: '123',
  //     hostId: '123',
  //     transactDate: DateTime.now(),
  //     status: 'Pending',
  //     amount: 1234.0,
  //     rentalId: '123',
  //     vehicleType: 'Sedan (4-seater)',
  //     startRental: DateTime.now(),
  //     endRental: DateTime.now(),
  //   );

  //   return FutureBuilder(
  //     future: apiService.addTransaction(nTransaction),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done)
  //         return Dialog(
  //           child: Wrap(
  //             alignment: WrapAlignment.center,
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(vertical: 20),
  //                 child: Text(
  //                   'Vehicle Rented',
  //                   style: FlutterFlowTheme.of(context).bodyLarge,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       else
  //         return Center(child: CircularProgressIndicator());
  //     },
  //   );
  // }
}
