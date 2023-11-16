import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joiner_1/components/cra/car_item_model.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_model.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_theme.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_widgets.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../flutter_flow/flutter_flow_util.dart';

class CarItemWidget extends StatefulWidget {
  final CarModel car;

  const CarItemWidget({super.key, required this.car});

  @override
  State<CarItemWidget> createState() => _CarItemWidgetState();
}

class _CarItemWidgetState extends State<CarItemWidget> {
  String? selectedAvailability;
  late CarItemModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CarItemModel());
    _model.priceInput = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: Navigator.of(context).pop,
                            icon: Icon(Icons.arrow_back)),
                        Text(
                          'Edit Car Rental Details',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 30, bottom: 0)),
                        Text('Availability',
                            style: TextStyle(
                                color: Color(0xFF7D7D7D), fontSize: 14))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<String>(
                          value: 'Available',
                          groupValue: selectedAvailability,
                          onChanged: (value) {
                            setState(() {
                              selectedAvailability = value!;
                            });
                          },
                        ),
                        Text('Available'),
                        Radio<String>(
                          value: 'Not Available',
                          groupValue: selectedAvailability,
                          onChanged: (value) {
                            setState(() {
                              selectedAvailability = value!;
                            });
                          },
                        ),
                        Text('Not Available'),
                      ],
                    ),
                    SizedBox(height: 16),
                    CustomTextInput(
                      label: 'Price',
                      controller: _model.priceInput,
                    ),
                    SizedBox(height: 16),
                    FFButtonWidget(
                      onPressed: () {
                        _model.editCar(widget.car.licensePlate!);
                      },
                      text: 'Edit',
                      options: FFButtonOptions(
                        height: 40,
                      ),
                    )
                  ]),
                ),
              ),
            );
          },
        );
        setState(() {});
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Color(0xff52B2FA),
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Text(
                // 'Available',
                widget.car.availability!,
                style: FlutterFlowTheme.of(context).labelMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            ),
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.all(10)),
                CachedNetworkImage(
                  imageUrl: widget.car.photoUrl!,
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  width: 150.0,
                  height: 100.0,
                  fit: BoxFit.fill,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0), // Adjust the radius as needed
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 30),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.car.vehicleType!,
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 16
                                  ),
                            ),
                            Row(
                              children: [
                                Text(
                                  NumberFormat.currency(
                                    symbol: '₱',
                                    decimalDigits: 0,
                                  ).format(widget.car.price),
                                  style: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 16
                                      ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text('/ day'),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text("Plate Number: "),
                                Text("${widget.car.licensePlate}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget editDialog() {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: 'Available',
                  groupValue: selectedAvailability,
                  onChanged: (value) {
                    setState(() {
                      selectedAvailability = value!;
                    });
                  },
                ),
                Text('Available'),
                Radio<String>(
                  value: 'Not Available',
                  groupValue: selectedAvailability,
                  onChanged: (value) {
                    setState(() {
                      selectedAvailability = value!;
                    });
                  },
                ),
                Text('Not Available'),
              ],
            ),
            SizedBox(height: 16),
            CustomTextInput(
              label: 'Price',
              controller: _model.priceInput,
            ),
            SizedBox(height: 16),
            FFButtonWidget(
              onPressed: () {
                _model.editCar(widget.car.licensePlate!);
              },
              text: 'Edit',
              options: FFButtonOptions(
                height: 40,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
