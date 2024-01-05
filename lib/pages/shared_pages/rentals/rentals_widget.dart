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
  late Auth provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    provider.refetchRentals();
  }

  @override
  void initState() {
    super.initState();
    provider = context.read<Auth>();
    provider.refetchRentals();
  }

  @override
  Widget build(BuildContext context) {
    final rentals = context.watch<Auth>().rentals;
    return Scaffold(
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: rentals.isEmpty
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
                          Icons.receipt,
                          size: 48.0,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text('No Rentals as of the moment'),
                  ],
                ),
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
