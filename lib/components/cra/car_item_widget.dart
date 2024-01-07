import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
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
                (context.read<Auth>() as CraController)
                    .removeCar(widget.car.licensePlate!)
                    .then((value) {
                  if (value) {
                    context.pop();
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

  Widget label(String label, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Text(content),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isCra = context.watch<Auth>() is CraController;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onLongPress: isCra ? handleLongPress : null,
        onTap: () {
          if (isCra) {
            context.pushNamed(
              'CarDetails',
              pathParameters: {'licensePlate': widget.car.licensePlate!},
              extra: widget.car,
            );
            return;
          }
          if (!isCra) {
            context.pushNamed('CarDetails', extra: widget.car);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            children: [
              Card(
                child: CachedNetworkImage(
                  imageUrl: getImageUrl(widget.car.photoUrl![0]),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  // width: 150.0,
                  height: 100.0,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Column(
                children: [
                  withCurrency(
                    Text(
                      '${widget.car.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  label('License Plate', '${widget.car.licensePlate}'),
                  label('Vehicle Type', '${widget.car.vehicleType}'),
                ],
              ),
              // Expanded(
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: DefaultTextStyle(
              //       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              //             fontWeight: FontWeight.w500,
              //             color: Theme.of(context).colorScheme.onSurfaceVariant,
              //           ),
              //       child: Column(
              //         children: [
              //           Row(
              //             children: [
              //               Expanded(
              //                 child: Text(
              //                   'License Plate:',
              //                   style: Theme.of(context).textTheme.titleSmall,
              //                 ),
              //               ),
              //               Expanded(
              //                 child: Text(
              //                   "${widget.car.licensePlate}",
              //                 ),
              //               ),
              //             ],
              //           ),
              //           Row(
              //             children: [
              //               Expanded(
              //                 child: Text(
              //                   'Vehicle Type:',
              //                   style: Theme.of(context).textTheme.titleSmall,
              //                 ),
              //               ),
              //               Expanded(
              //                 child: Text(
              //                   widget.car.vehicleType,
              //                 ),
              //               ),
              //             ],
              //           ),
              //           Row(
              //             children: [
              //               Expanded(
              //                 child: Text(
              //                   'Price:',
              //                   style: Theme.of(context).textTheme.titleSmall,
              //                 ),
              //               ),
              //               Expanded(
              //                 child: Row(
              //                   children: [
              //                     withCurrency(
              //                       Text(
              //                         widget.car.price.toString(),
              //                         style: Theme.of(context)
              //                             .textTheme
              //                             .headlineMedium,
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       width: 4,
              //                     ),
              //                     Text('/ day'),
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
