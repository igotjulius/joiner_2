import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joiner_1/components/cra/car_item_widget.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:provider/provider.dart';

class CraCarWidget extends StatefulWidget {
  const CraCarWidget({super.key});

  @override
  State<CraCarWidget> createState() => _CraCarWidgetState();
}

class _CraCarWidgetState extends State<CraCarWidget> {
  @override
  void initState() {
    super.initState();
    final controller = context.read<Auth>() as CraController;
    controller.refetchCraCars();
  }

  @override
  Widget build(BuildContext context) {
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

  Padding mainBody() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: displayCars(),
    );
  }

  Widget displayCars() {
    final cars = (context.watch<Auth>() as CraController).cars;
    return cars.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.not_interested,
                      size: 48.0,
                      color: Colors.grey,
                    ),
                    Icon(
                      Icons.directions_car,
                      size: 48.0,
                      color: Colors.grey,
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Text('You don\'t have Registered Cars yet'),
              ],
            ),
          )
        : SingleChildScrollView(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: cars.length,
              itemBuilder: (context, index) {
                final car = cars[index];
                return CarItemWidget(car: car);
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 10,
                );
              },
            ),
          );
  }
}
