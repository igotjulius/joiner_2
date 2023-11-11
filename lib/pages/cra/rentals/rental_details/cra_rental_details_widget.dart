import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/rental_model.dart';

class RentalDetails extends StatefulWidget {
  final RentalModel? rental;
  const RentalDetails({super.key, this.rental});

  @override
  State<RentalDetails> createState() => _RentalDetailsState();
}

class _RentalDetailsState extends State<RentalDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/car.png',
                  height: MediaQuery.of(context).size.height / 4,
                ),
                Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.teal,
                    ),
                    Text('Paid'),
                    Text('₱${widget.rental?.price}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/User_01c_(1).png',
                      height: 40,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rented by:'),
                        Text('${widget.rental?.renterName}'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              indent: 8,
              endIndent: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('TRANSACTION ID'),
                Text('${widget.rental?.id}'),
                SizedBox(
                  height: 10,
                ),
                timeline(),
              ],
            ),
          ].divide(
            SizedBox(
              height: 10,
            ),
          ),
        ),
      ),
    );
  }

  Widget timeline() {
    return Card(
      margin: EdgeInsets.all(0),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Payment'),
                Row(
                  children: [
                    Text(DateFormat("EEE").format(widget.rental!.createdAt!)),
                    Container(
                      height: 5,
                      width: 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      DateFormat("MMM d 'at' h:mm a")
                          .format(widget.rental!.createdAt!),
                    ),
                  ].divide(
                    SizedBox(
                      width: 10,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pick-up'),
                Row(
                  children: [
                    Text(DateFormat("EEE").format(widget.rental!.startRental!)),
                    Container(
                      height: 5,
                      width: 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                    ),
                    Text(DateFormat("MMM d 'at' h:mm a")
                        .format(widget.rental!.startRental!)),
                  ].divide(
                    SizedBox(
                      width: 10,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Return'),
                Row(
                  children: [
                    Text(DateFormat("E").format(widget.rental!.endRental!)),
                    Container(
                      height: 5,
                      width: 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                    ),
                    Text(DateFormat("MMM d 'at' h:mm a")
                        .format(widget.rental!.endRental!)),
                  ].divide(
                    SizedBox(
                      width: 10,
                    ),
                  ),
                ),
              ],
            ),
          ].divide(
            SizedBox(
              height: 10,
            ),
          ),
        ),
      ),
    );
  }
}
