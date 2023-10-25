import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_theme.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/pages/cra/earnings/earnings_model.dart';

class EarningsWidget extends StatefulWidget {
  const EarningsWidget({super.key});

  @override
  State<EarningsWidget> createState() => _EarningsWidgetState();
}

class _EarningsWidgetState extends State<EarningsWidget> {
  late EarningsModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EarningsModel());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Earnings',
                style: FlutterFlowTheme.of(context).headlineMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '6,789.00',
                    style: FlutterFlowTheme.of(context).titleLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    'earned this month',
                    style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ].divide(
                  SizedBox(
                    width: 10,
                  ),
                ),
              ),
              _model.getCraRentals(),
            ].divide(
              SizedBox(
                height: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
