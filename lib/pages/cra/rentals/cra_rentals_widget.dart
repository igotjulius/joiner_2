import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/flutter_flow/nav/nav.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:joiner_1/widgets/atoms/user_rental_info.dart';

class CraRentalsWidget extends StatefulWidget {
  const CraRentalsWidget({super.key});

  @override
  State<CraRentalsWidget> createState() => _CraRentalsWidgetState();
}

class _CraRentalsWidgetState extends State<CraRentalsWidget> {
  Future<List<RentalModel>?>? _fetchRentals;

  @override
  void initState() {
    super.initState();
    _fetchRentals = CraController.getCraRentals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rentals'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: getCraRentals(),
      ),
    );
  }

  FutureBuilder<List<RentalModel>?> getCraRentals() {
    return FutureBuilder(
      future: _fetchRentals,
      builder: (context, snapshot) {
        final rentals = snapshot.data;
        if (rentals == null)
          return Center(
            child: Text('No rentals as of the moment'),
          );
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
                  return InkWell(
                    onTap: () {
                      context.pushNamed(
                        'RentalDetails',
                        extra: <String, dynamic>{
                          'rental': rental,
                        },
                      );
                    },
                    child: RentalInfo(
                      rental: rental,
                    ),
                  );
                },
                itemCount: rentals.length,
              ),
            ],
          ),
        );
      },
    );
  }
}
