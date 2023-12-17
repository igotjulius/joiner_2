import 'package:joiner_1/components/cra/car_item_widget.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/car_model.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class ListingsWidget extends StatefulWidget {
  const ListingsWidget({Key? key}) : super(key: key);

  @override
  _ListingsWidgetState createState() => _ListingsWidgetState();
}

class _ListingsWidgetState extends State<ListingsWidget> {
  Future<List<CarModel>?>? _fetchAvailableCars;

  @override
  void initState() {
    super.initState();
    _fetchAvailableCars = UserController.getAvailableCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Rent a Car',
        ),
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: getAvailableCars(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<CarModel>?> getAvailableCars() {
    return FutureBuilder(
      future: _fetchAvailableCars,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done)
          return Center(
            child: CircularProgressIndicator(),
          );
        if (snapshot.data == null)
          return Center(
            child: Text('No available cars for today :('),
          );
        final cars = snapshot.data!;
        return SingleChildScrollView(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: cars.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  context.pushNamed('Booking', extra: {'car': cars[index]});
                },
                child: CarItemWidget(car: cars[index]),
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
