import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_widgets.dart';

class RentalInfo extends StatefulWidget {
  final double? amount;
  final int? duration;
  final String? vehicleOwner;
  final String? pickupDate;
  final String? returnDate;

  const RentalInfo({
    super.key,
    this.amount,
    this.duration,
    this.vehicleOwner,
    this.pickupDate,
    this.returnDate,
  });

  @override
  State<RentalInfo> createState() => _RentalInfoState();
}

class _RentalInfoState extends State<RentalInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150.0, // Set the desired width for the card
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Directionality(
              textDirection: TextDirection.ltr, // Set textDirection here
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: FFButtonWidget(
                          text: 'In 3 days',
                          onPressed: () {},
                          options: FFButtonOptions(
                              color: Colors.blueAccent,
                              width: 100.0,
                              height: 30.0),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Contact owner'),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.asset(
                            'assets/images/car.png',
                            width: 150.0,
                            height: 150.0,
                            fit: BoxFit.fill,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '₱${widget.amount}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'for ${widget.duration} day${widget.duration! > 1 ? 's' : ''}',
                      ),
                    ],
                  ),
                  Divider(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Car owner:',
                      ),
                      Text(
                        '${widget.vehicleOwner}',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'PICK-UP DATE:',
                      ),
                      Text(
                        '${widget.pickupDate}',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'RETURN DATE:',
                      ),
                      Text(
                        '${widget.returnDate}',
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
