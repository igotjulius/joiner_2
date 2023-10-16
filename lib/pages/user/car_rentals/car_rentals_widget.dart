import '../../../flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'car_rentals_model.dart';
export 'car_rentals_model.dart';

class CarRentalsWidget extends StatefulWidget {
  const CarRentalsWidget({
    Key? key,
    this.loc,
  }) : super(key: key);

  final LatLng? loc;

  @override
  _CarRentalsWidgetState createState() => _CarRentalsWidgetState();
}

class _CarRentalsWidgetState extends State<CarRentalsWidget> {
  late CarRentalsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CarRentalsModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Upcoming Rentals'),
                    FFButtonWidget(
                      text: 'Browse Listings',
                      onPressed: () {
                        context.pushNamed(
                          'Listings',
                          extra: <String, dynamic>{
                            kTransitionInfoKey: TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.rightToLeft,
                            ),
                          },
                        );
                      },
                      options: FFButtonOptions(height: 40),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
