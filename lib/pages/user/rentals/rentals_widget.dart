import 'package:joiner_1/models/rental_model.dart';
import 'package:joiner_1/models/user_model.dart';
import 'package:joiner_1/pages/user/provider/user_provider.dart';
import 'package:joiner_1/widgets/atoms/user_rental_info.dart';
import 'package:provider/provider.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'rentals_model.dart';
export 'rentals_model.dart';

class RentalsWidget extends StatefulWidget {
  const RentalsWidget({super.key});

  @override
  _RentalsWidgetState createState() => _RentalsWidgetState();
}

class _RentalsWidgetState extends State<RentalsWidget> {
  late RentalsModel _model;
  List<RentalModel>? rentals;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RentalsModel());
    rentals = context.read<UserProvider>().currentUser.rentals;
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                context.pushNamed(
                  'Listings',
                  extra: <String, dynamic>{
                    kTransitionInfoKey: TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.rightToLeft,
                    ),
                  },
                );
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
                  itemCount: rentals?.length,
                  itemBuilder: (context, index) {
                    return RentalInfo(
                      rental: rentals?[index],
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
