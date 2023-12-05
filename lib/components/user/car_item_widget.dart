import 'package:flutter/material.dart';
import 'package:joiner_1/components/user/car_item_model.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/car_model.dart';

class CarItemWidget extends StatefulWidget {
  final CarModel? car;
  const CarItemWidget({super.key, required this.car});

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
        context.pushNamed(
          'Booking',
          extra: {'car': widget.car},
        );
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
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: double.infinity,
                color: Color(0xff52b2fa),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.car!.vehicleType!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network(
                    widget.car!.photoUrl!.first,
                    width: 150.0,
                    height: 100.0,
                    fit: BoxFit.fill,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "₱${widget.car!.price}0",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text('/ day'),
                          ].divide(
                            SizedBox(
                              width: 4,
                            ),
                          ),
                        ),
                        Text(
                          'Automatic',
                        ),
                        Text(
                          '10 Reviews',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ].divide(SizedBox.shrink()),
        ),
      ),
    );
  }
}
