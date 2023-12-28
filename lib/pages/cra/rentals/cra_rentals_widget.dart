import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/widgets/atoms/user_rental_info.dart';
import 'package:provider/provider.dart';

class CraRentalsWidget extends StatefulWidget {
  const CraRentalsWidget({super.key});

  @override
  State<CraRentalsWidget> createState() => _CraRentalsWidgetState();
}

class _CraRentalsWidgetState extends State<CraRentalsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rentals'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: displayRentals(),
      ),
    );
  }

  Widget displayRentals() {
    return Consumer<AuthController>(builder: (_, value, __) {
      final rentals = (value.userTypeController as CraController).rentals;
      return SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 10,
                );
              },
              itemBuilder: (context, index) {
                final rental = rentals[index];
                return RentalInfo(
                  rental: rental,
                );
              },
              itemCount: rentals.length,
            ),
          ],
        ),
      );
    });
  }
}
