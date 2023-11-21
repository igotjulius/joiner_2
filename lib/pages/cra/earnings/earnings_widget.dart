import 'package:flutter/material.dart';
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
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Earnings',
          ),
          Expanded(
            child: _model.getCraRentals(),
          ),
        ].divide(
          SizedBox(
            height: 20,
          ),
        ),
      ),
    );
  }
}
