import 'package:flutter/material.dart';
import 'package:joiner_1/components/user/car_item_model.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_theme.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/car_model.dart';

class CarItemWidget extends StatefulWidget {
  final CarModel? car;
  final Function callback;
  const CarItemWidget(this.callback, {super.key, required this.car});

  @override
  _CarItemWidgetState createState() => _CarItemWidgetState();
}

class _CarItemWidgetState extends State<CarItemWidget> {
  late CarItemModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CarItemModel());

    _model.car = widget.car;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        context.pushNamed('Booking',
            extra: {'licensePlate': _model.car!.licensePlate});
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xff52B2FA)),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                'assets/images/car.png',
                width: 114.0,
                height: 80.0,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      "₱${widget.car!.price}",
                      style: FlutterFlowTheme.of(context).labelLarge.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text('/ day'),
                  ].divide(
                    SizedBox(
                      width: 4,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                color: Color(0xff52b2fa),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.car!.vehicleType!,
                          style:
                              FlutterFlowTheme.of(context).labelLarge.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                        ),
                        Text(
                          'Automatic',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        Text(
                          '10 Reviews',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ].divide(SizedBox.shrink()),
        ),
      ),
    );
  }
}
