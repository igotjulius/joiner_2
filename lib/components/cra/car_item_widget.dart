import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_theme.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_widgets.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CarItemWidget extends StatefulWidget {
  final CarModel car;
  const CarItemWidget({super.key, required this.car});

  @override
  State<CarItemWidget> createState() => _CarItemWidgetState();
}

class _CarItemWidgetState extends State<CarItemWidget> {
  String? selectedAvailability;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        showDialog(
            context: context,
            builder: (context) {
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
                                  print(value);
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
                          CustomTextInput(label: 'License Plate'),
                          SizedBox(height: 16),
                          CustomTextInput(label: 'Vehicle Type'),
                          SizedBox(height: 16),
                          CustomTextInput(label: 'Price'),
                          SizedBox(height: 16),
                          FFButtonWidget(
                            onPressed: () {
                              print('');
                            },
                            text: 'Edit',
                            options: FFButtonOptions(
                              height: 40,
                            ),
                          )
                        ]),
                      )));
            });
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
            Padding(
              padding: const EdgeInsets.all(10),
              child: CachedNetworkImage(
                imageUrl: widget.car.photoUrl!,
                errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red,),
                placeholder: (context, url) => const CircularProgressIndicator(),
                width: 130.0,
                height: 80.0,
                fit: BoxFit.fill,
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
                      widget.car.vehicleType!,
                      style: FlutterFlowTheme.of(context).labelMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                    ),
                    Row(
                      children: [
                        Text(
                          "₱${widget.car.price}",
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
                    SizedBox(
                          height: 10,
                        ),
                    Row(
                      children: [
                        Text("Plate Number: "),
                        Text("${widget.car.licensePlate}", style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
