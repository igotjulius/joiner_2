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
    return Scaffold(
      appBar: AppBar(
        title: Text('Rentals'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _model.getCraRentals(),
          ],
        ),
      ),
    );
  }
}
