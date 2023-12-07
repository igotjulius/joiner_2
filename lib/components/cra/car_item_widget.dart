import 'package:flutter/material.dart';
import 'package:joiner_1/components/cra/car_item_model.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CarItemWidget extends StatefulWidget {
  final CarModel car;

  const CarItemWidget({super.key, required this.car});

  @override
  State<CarItemWidget> createState() => _CarItemWidgetState();
}

class _CarItemWidgetState extends State<CarItemWidget> {
  late CarItemModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CarItemModel());
    _model.priceInput = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${widget.car.licensePlate}",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  widget.car.isAvailable! ? 'Available' : 'Unavailable',
                ),
              ],
            ),
          ),
          Row(
            children: [
              Padding(padding: const EdgeInsets.all(10)),
              CachedNetworkImage(
                imageUrl: getImageUrl(widget.car.photoUrl![0]),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                width: 150.0,
                height: 100.0,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
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
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 30, bottom: 30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.car.vehicleType!,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                NumberFormat.currency(
                                  symbol: '₱',
                                  decimalDigits: 0,
                                ).format(widget.car.price),
                                style: TextStyle(fontWeight: FontWeight.bold),
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
    );
  }
}
