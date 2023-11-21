import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/pages/cra/car/cra_car_model.dart';

class CraCarWidget extends StatefulWidget {
  const CraCarWidget({super.key});

  @override
  State<CraCarWidget> createState() => _CraCarWidgetState();
}

class _CraCarWidgetState extends State<CraCarWidget> {
  late CraCarModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CraCarModel());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Manage Cars',
              ),
              FilledButton(
                onPressed: () {
                  context.pushNamed('RegisterCar');
                },
                child: Text('Add a car'),
              ),
            ],
          ),
          Expanded(
            child: _model.getCars(setState),
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
