import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joiner_1/components/cra/car_item_widget.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/models/car_model.dart';

class CraCarWidget extends StatefulWidget {
  const CraCarWidget({super.key});

  @override
  State<CraCarWidget> createState() => _CraCarWidgetState();
}

class _CraCarWidgetState extends State<CraCarWidget> {
  Future<List<CarModel>?>? _fetchCars;

  @override
  void initState() {
    super.initState();
    _fetchCars = CraController.getCraCars();
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
      child: Center(
        child: getCars(),
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
              return CarItemWidget(car: car);
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
