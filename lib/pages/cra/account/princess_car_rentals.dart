import 'package:flutter/material.dart';
// ignore: unused_import
import 'dart:ui_web';

void main() {
  runApp(MaterialApp(
    home: PrinccesCarRentals(),
  ));
}

class PrinccesCarRentals extends StatefulWidget {
  final double? Upayout;
  final int? numBookings;
  final String? payoutToBeRecieved;
  final String? weeklyPayoutSchedule;
  final int? Ratings;
  final int? Contactno;
  const PrinccesCarRentals(
      {Key? key,
      this.Upayout,
      this.numBookings,
      this.payoutToBeRecieved,
      this.weeklyPayoutSchedule,
      this.Ratings,
      this.Contactno})
      : super(key: key);

  @override
  State<PrinccesCarRentals> createState() => _PrinccesCarRentalsState();
}

class _PrinccesCarRentalsState extends State<PrinccesCarRentals> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text('PrinccesCarRentals'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/User_01c_(1).png',
                        height: 100.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text('Edit Photo'),
            Text('Princess Car Rentals'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0),
                      borderRadius: BorderRadius.circular(8.0)),
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Upcoming Payout'),
                      Text('${widget.Upayout}'),
                      Text('${widget.numBookings} successful bookings'),
                      Divider(),
                      Text(
                          'Payout to be recieved on or before: ${widget.payoutToBeRecieved}'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1.0, color: Colors.blue),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.error,
                                      color: Colors.blue,
                                      size: 24.0,
                                    ),
                                    SizedBox(
                                      width: 3.0,
                                    ),
                                    Text(
                                        'Payout schedule is weekly on every ${widget.weeklyPayoutSchedule}'),
                                  ],
                                ),
                              ],
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Rating'),
                          Text('${widget.Ratings}'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Contact no.'),
                          Text('${widget.Contactno}'),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.key_sharp,
                              color: Colors.grey,
                              size: 24.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text('Change Password'),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.account_box,
                              color: Colors.grey,
                              size: 24.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text('Account Settings'),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.help_center,
                              color: Colors.grey,
                              size: 24.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text('Help Center'),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.grey,
                              size: 24.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text('Logout'),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
