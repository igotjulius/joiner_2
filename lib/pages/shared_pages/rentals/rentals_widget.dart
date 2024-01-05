import 'package:go_router/go_router.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:joiner_1/pages/shared_pages/rentals/rental_info.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class RentalsWidget extends StatefulWidget {
  const RentalsWidget({super.key});

  @override
  _RentalsWidgetState createState() => _RentalsWidgetState();
}

class _RentalsWidgetState extends State<RentalsWidget> {
  late Auth provider;
  late List<RentalModel> rentals;
  late List<RentalModel> filteredRentals;
  int? selectedMonth;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    provider.refetchRentals();
  }

  @override
  void initState() {
    super.initState();
    provider = context.read<Auth>();
    rentals = provider.rentals;
    filteredRentals = List.from(rentals);
    provider.refetchRentals();
  }

  List<RentalModel> filterAndSortRentalsByMonth(int month) {
    return rentals
        .where((rental) => rental.startRental!.month == month)
        .toList()
      ..sort((a, b) => a.startRental!.compareTo(b.startRental!));
  }

  @override
  Widget build(BuildContext context) {
    rentals = context.watch<Auth>().rentals;
    double totalSum =
        filteredRentals.fold(0.0, (sum, rental) => sum + (rental.price ?? 0.0));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rentals',
        ),
        actions: provider is CraController
            ? [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                      Text('Earnings: ',
                          style: Theme.of(context).textTheme.displaySmall),
                      withCurrency(Text(
                        '${totalSum.toStringAsFixed(2)}',
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      )),
                    ],
                  ),
                )
              ]
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
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FilledButton(
                            child: Text(
                                'Filter by ${selectedMonth != null ? Month.values[selectedMonth! - 1].toString().split('.').last : 'Month'}'),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Choose a Month'),
                                    content: Column(
                                      children: List.generate(Month.values.length,
                                          (index) {
                                        final month = index + 1;
                                        return ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              selectedMonth = month;
                                              filteredRentals =
                                                  filterAndSortRentalsByMonth(
                                                      selectedMonth!);
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                              '${Month.values[index].toString().split('.').last}'),
                                        );
                                      }),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      if (selectedMonth != null)
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              selectedMonth = null;
                              filteredRentals = rentals;
                            });
                          },
                        ),
                    ],
                  ),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredRentals.length,
                      itemBuilder: (context, index) {
                        RentalModel rental = filteredRentals[index];
                        return RentalInfo(
                          rental: rental,
                        );
                      },
                    ),
                  ),
                ].divide(SizedBox(height: 10)),
              ),
      ),
    );
  }
}
