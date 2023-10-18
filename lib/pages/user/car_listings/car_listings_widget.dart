import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_theme.dart';
import 'package:joiner_1/pages/user/car_listings/car_listings_model.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarListingsWidget extends StatefulWidget {
  const CarListingsWidget({Key? key}) : super(key: key);

  @override
  _CarListingsWidgetState createState() => _CarListingsWidgetState();
}

class _CarListingsWidgetState extends State<CarListingsWidget> {
  late CarListingsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CarListingsModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rent a Car',
                  style: FlutterFlowTheme.of(context).headlineMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: UserController.getAvailableCars(setState),
                ),
              ].divide(
                SizedBox(
                  height: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}