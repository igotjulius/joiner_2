import 'package:flutter/material.dart';
import 'package:joiner_1/components/cra/add_car_widget.dart';
import 'package:joiner_1/components/cra/car_item_widget.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_theme.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_widgets.dart';

class CarWidget extends StatefulWidget {
  const CarWidget({super.key});

  @override
  State<CarWidget> createState() => _CarWidgetState();
}

class _CarWidgetState extends State<CarWidget> {
  @override
  void initState() {
    super.initState();
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
                    style: FlutterFlowTheme.of(context)
                        .titleLarge
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  FFButtonWidget(
                    text: 'Add a Car',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AddCarModal(),
                      );
                    },
                    options: FFButtonOptions(height: 40.0),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: CraController.getCars(),
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
