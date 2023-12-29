import 'package:go_router/go_router.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:joiner_1/pages/shared_pages/rentals/rental_info.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class RentalsWidget extends StatefulWidget {
  const RentalsWidget({super.key});

  @override
  _RentalsWidgetState createState() => _RentalsWidgetState();
}

class _RentalsWidgetState extends State<RentalsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Auth provider;

  @override
  void initState() {
    super.initState();
    provider = context.read<Auth>();
    provider.refetchRentals();
  }

  @override
  Widget build(BuildContext context) {
    final rentals = provider.rentals;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Rentals',
        ),
        actions: provider is CraController
            ? null
            : [
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: rentals.isEmpty
            ? Center(
                child: Text('No rentals at this moment'),
              )
            : Column(
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
    );
  }
}
