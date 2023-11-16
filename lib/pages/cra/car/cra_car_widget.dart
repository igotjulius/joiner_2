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
    return SafeArea(
      top: true,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
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
              Container(
                height: MediaQuery.of(context).size.height,
                child: _model.getCars(),
              ),
            ].divide(SizedBox(
              height: 10,
            )),
          ),
        ),
      ),
    );
  }
}
