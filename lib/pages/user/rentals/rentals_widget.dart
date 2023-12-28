import 'package:go_router/go_router.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:joiner_1/widgets/atoms/user_rental_info.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class RentalsWidget extends StatefulWidget {
  const RentalsWidget({super.key});

  @override
  _RentalsWidgetState createState() => _RentalsWidgetState();
}

class _RentalsWidgetState extends State<RentalsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    (context.read<Auth>() as UserController).refetchRentals();
  }

  @override
  Widget build(BuildContext context) {
    final rentals = (context.watch<Auth>() as UserController).rentals;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Rentals',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: FilledButton(
              child: Text('Listings'),
              onPressed: () {
                context.pushNamed('Listings');
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: rentals.length,
                  itemBuilder: (context, index) {
                    RentalModel rental = rentals[index];
                    return RentalInfo(
                      rental: rental,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
