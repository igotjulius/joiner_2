import 'package:flutter/material.dart';
import 'package:joiner_1/components/cra/car_item_model.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
      onLongPress: () {
        _model.deleteCar(widget.car.licensePlate!);
        setState(() {});
      },
      onTap: () {
        context.pushNamed(
          'CarDetails',
          pathParameters: {'licensePlate': widget.car.licensePlate!},
          extra: <String, dynamic>{
            'car': widget.car,
          },
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Color(0xff52B2FA),
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Text(
                // 'Available',
                widget.car.availability!,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CachedNetworkImage(
                imageUrl: environment == 'TEST'
                    ? getImageUrl(widget.car.ownerId!, widget.car.photoUrl![0])
                    : widget.car.photoUrl![0],
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
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
                    ),
                    Row(
                      children: [
                        Text(
                          "₱${widget.car.price}",
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
                        Text(
                          "${widget.car.licensePlate}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
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
