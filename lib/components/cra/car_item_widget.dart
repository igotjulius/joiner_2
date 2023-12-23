import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joiner_1/app_state.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/pages/provider/cra_provider.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

class CarItemWidget extends StatefulWidget {
  final CarModel car;
  const CarItemWidget({super.key, required this.car});

  @override
  State<CarItemWidget> createState() => _CarItemWidgetState(car);
}

class _CarItemWidgetState extends State<CarItemWidget> {
  _CarItemWidgetState(this.car);
  CarModel car;
  late CarItemModel _model;

  @override
  void initState() {
    super.initState();
    _model = CarItemModel();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.car.licensePlate}",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              Text(
                widget.car.availability!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
          Divider(
            indent: 4,
            endIndent: 4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Card(
                  surfaceTintColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  child: CachedNetworkImage(
                    imageUrl: widget.car.photoUrl!.isEmpty
                        ? ''
                        : getImageUrl(widget.car.photoUrl![0]),
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
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.car.vehicleType!,
                      ),
                      Row(
                        children: [
                          withCurrency(
                            Text(
                              widget.car.price.toString(),
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CarItemModel {
  Future<bool> delete(String licensePlate) async {
    return await CraController.deleteCar(licensePlate);
  }
}
