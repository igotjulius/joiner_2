import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_theme.dart';
import 'package:joiner_1/models/car_model.dart';

class CarItemWidget extends StatelessWidget {
  final CarModel car;
  const CarItemWidget({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff52B2FA)),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Color(0xff52B2FA),
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: Text(
              // 'Available',
              car.availability!,
              style: FlutterFlowTheme.of(context).labelMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              'assets/images/car.png',
              width: 114.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car.vehicleType!,
                    style: FlutterFlowTheme.of(context).labelMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                  ),
                  Row(
                    children: [
                      Text(
                        "₱${car.price}",
                        style:
                            FlutterFlowTheme.of(context).labelMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text('/ day'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
