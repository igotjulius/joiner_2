import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joiner_1/app_state.dart';
import 'package:joiner_1/components/cra/car_item_widget.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/models/car_model.dart';
import 'package:joiner_1/pages/provider/cra_provider.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:provider/provider.dart';

class CraCarWidget extends StatefulWidget {
  const CraCarWidget({super.key});

  @override
  State<CraCarWidget> createState() => _CraCarWidgetState();
}

class _CraCarWidgetState extends State<CraCarWidget> {
  List<CarModel>? cars;
  Future<List<CarModel>?>? _fetchCars;

  @override
  void initState() {
    super.initState();
    _fetchCars = CraController.getCraCars();
  }

  @override
  Widget build(BuildContext context) {
    cars = context.watch<CraProvider>().vehicles;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manage Cars',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed('RegisterCar');
        },
        child: Icon(Icons.add),
      ),
      body: mainBody(),
    );
  }

  Widget mainBody() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: cars != null ? displayCars(cars!) : fetchCars(),
    );
  }

  FutureBuilder<List<CarModel>?> fetchCars() {
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
        return displayCars(cars);
      },
    );
  }

  Widget displayCars(List<CarModel> cars) {
    final isCra = context.watch<FFAppState>().isCra;
    return SingleChildScrollView(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return Card(
            surfaceTintColor: Theme.of(context).colorScheme.secondary,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onLongPress: isCra
                  ? () {
                      handleLongPress(car);
                    }
                  : null,
              onTap: () {
                if (isCra) {
                  context.pushNamed(
                    'CarDetails',
                    pathParameters: {'licensePlate': car.licensePlate!},
                    extra: <String, dynamic>{
                      'car': car,
                    },
                  );
                  return;
                }
                if (!isCra) {
                  context.pushNamed('CarDetails', extra: {'car': car});
                }
              },
              child: CarItemWidget(car: car),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 10,
          );
        },
      ),
    );
  }

  void handleLongPress(CarModel car) {
    if (car.availability == 'On rent') {
      ScaffoldMessenger.of(context).showSnackBar(
        showError(
          'Car still on rent',
          Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }
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
                // showDialogLoading(context);
                // _model.delete(widget.car.licensePlate!).then((value) {
                //   if (value) {
                //     context.pop();
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       showSuccess('Car removed'),
                //     );
                //   } else {
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       showError(
                //           'Car removed', Theme.of(context).colorScheme.error),
                //     );
                //   }
                // });
                removeCar(car);
                context.pop();
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

  void removeCar(CarModel car) {
    context.read<CraProvider>().removeCar(car);
    setState(() {});
  }
}
