import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joiner_1/components/cra/car_item_widget.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/pages/cra/car/cra_car_model.dart';
import 'package:joiner_1/utils/utils.dart';

class CraCarWidget extends StatefulWidget {
  const CraCarWidget({super.key});

  @override
  State<CraCarWidget> createState() => _CraCarWidgetState();
}

class _CraCarWidgetState extends State<CraCarWidget> {
  late CraCarModel _model;
  Future<List<CarModel>?>? _fetchCars;

  @override
  void initState() {
    super.initState();
    _model = CraCarModel();
    _fetchCars = CraController.getCraCars();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Manage Cars',
              ),
              FilledButton(
                onPressed: () {
                  context.pushNamed('RegisterCar');
                },
                child: Text('Add a car'),
              ),
            ],
          ),
          Expanded(
            child: getCars(),
          ),
        ].divide(
          SizedBox(
            height: 20,
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<CarModel>?> getCars() {
    return FutureBuilder(
      future: _fetchCars,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done)
          return Center(
            child: CircularProgressIndicator(),
          );

        List<CarModel>? cars = snapshot.data;
        if (cars == null)
          return Center(
            child: Text('No registered cars'),
          );
        return SingleChildScrollView(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: cars.length,
            itemBuilder: (context, index) {
              final car = cars[index];
              return InkWell(
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Remove'),
                        titlePadding:
                            EdgeInsets.only(left: 20, top: 20, right: 20),
                        contentPadding: EdgeInsets.all(20),
                        content: Text('Are you sure to remove this car?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              showDialogLoading(context);
                              _model.delete(car.licensePlate!).then((value) {
                                if (value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    showSuccess('Car removed'),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    showError('Car removed',
                                        Theme.of(context).colorScheme.error),
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
                },
                onTap: () {
                  context.pushNamed(
                    'CarDetails',
                    pathParameters: {'licensePlate': car.licensePlate!},
                    extra: <String, dynamic>{
                      'car': car,
                    },
                  );
                },
                child: CarItemWidget(car: car),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10,
              );
            },
          ),
        );
      },
    );
  }
}
