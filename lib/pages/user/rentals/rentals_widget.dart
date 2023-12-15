import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'rentals_model.dart';
export 'rentals_model.dart';

class RentalsWidget extends StatefulWidget {
  const RentalsWidget({
    Key? key,
    this.loc,
  }) : super(key: key);

  final LatLng? loc;

  @override
  _RentalsWidgetState createState() => _RentalsWidgetState();
}

class _RentalsWidgetState extends State<RentalsWidget> {
  late RentalsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RentalsModel());
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
          'Upcoming Rentals',
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
                child: _model.getRentals(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
