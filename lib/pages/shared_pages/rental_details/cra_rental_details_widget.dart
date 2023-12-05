import 'package:flutter/material.dart';
import 'package:joiner_1/components/user/linkable_lobby.dart';
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              onPressed: () {
                showModalBottomSheet(
                  showDragHandle: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Wrap(
                      children: [
                        LinkableLobby(
                          rental: widget.rental,
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Link to a lobby'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/successful-payment.png',
                  height: 200,
                  width: 200,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '₱${widget.rental?.price}',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(fontWeight: FontWeight.w600),
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
                Text(
                  'Transaction Id',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text('${widget.rental?.id}'),
                SizedBox(
                  height: 10,
                ),
                timeline(),
              ],
            ),
          ].divide(
            SizedBox(
              height: 8,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pick-up',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Return',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
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
