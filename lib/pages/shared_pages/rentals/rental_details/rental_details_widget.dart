import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:joiner_1/components/user/linkable_lobby.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:provider/provider.dart';

class RentalDetails extends StatefulWidget {
  final RentalModel? rental;
  const RentalDetails({super.key, this.rental});

  @override
  State<RentalDetails> createState() => _RentalDetailsState();
}

class _RentalDetailsState extends State<RentalDetails> {
  @override
  Widget build(BuildContext context) {
    final isCra = context.watch<Auth>() is CraController;
    return Scaffold(
      appBar: AppBar(
        actions: isCra
            ? null
            : [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        showDragHandle: true,
                        isScrollControlled: true,
                        constraints: BoxConstraints.expand(
                            height: MediaQuery.of(context).size.height * 0.7),
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
                withCurrency(
                  Text(
                    '${widget.rental?.price}',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
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
                label('Rental Id', widget.rental!.id!),
                label('Payment Id', widget.rental!.paymentId!),
                label(
                  'Payment Status',
                  widget.rental!.paymentStatus! == 'active'
                      ? 'Pending payment'
                      : 'Paid',
                ),
                timeline(),
              ].divide(
                SizedBox(
                  height: 10,
                ),
              ),
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

  Widget label(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(
          height: 4,
        ),
        Text(content),
      ],
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
                  'Transaction date',
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
