import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joiner_1/app_state.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

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
    _model = CarItemModel();
  }

  void handleLongPress() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Remove'),
          titlePadding: EdgeInsets.only(left: 20, top: 20, right: 20),
          contentPadding: EdgeInsets.all(20),
          content: Text('Are you sure to remove this car?'),
          actions: [
            TextButton(
              onPressed: () {
                showDialogLoading(context);
                _model.delete(widget.car.licensePlate!).then((value) {
                  if (value) {
                    context.pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      showSuccess('Car removed'),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      showError(
                          'Car removed', Theme.of(context).colorScheme.error),
                    );
                  }
                });
              },
              child: Text('Remove'),
            ),
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isCra = context.watch<FFAppState>().isCra;
    return Card(
      surfaceTintColor: Theme.of(context).colorScheme.secondary,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onLongPress: isCra ? handleLongPress : null,
        onTap: () {
          if (isCra) {
            context.pushNamed(
              'CarDetails',
              pathParameters: {'licensePlate': widget.car.licensePlate!},
              extra: <String, dynamic>{
                'car': widget.car,
              },
            );
            return;
          }
          if (!isCra) {
            context.pushNamed('CarDetails', extra: {'car': widget.car});
          }
        },
        child: Padding(
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
                        imageUrl: getImageUrl(widget.car.photoUrl![0]),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
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
        ),
      ),
    );
  }
}

class CarItemModel {
  Future<bool> delete(String licensePlate) async {
    return await CraController.deleteCar(licensePlate);
  }
}
