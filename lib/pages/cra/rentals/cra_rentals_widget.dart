import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_model.dart';
import 'package:joiner_1/pages/cra/rentals/cra_rentals_model.dart';

class CraRentalsWidget extends StatefulWidget {
  const CraRentalsWidget({super.key});

  @override
  State<CraRentalsWidget> createState() => _CraRentalsWidgetState();
}

class _CraRentalsWidgetState extends State<CraRentalsWidget> {
  late CraRentalsModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CraRentalsModel());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text('Rentals'),
          ),
          Expanded(
            child: _model.getCraRentals(),
          ),
        ],
      ),
    );
  }
}
