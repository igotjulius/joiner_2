import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/rental_model.dart';

class RentalInfo extends StatefulWidget {
  final RentalModel? rental;

  const RentalInfo({
    super.key,
    this.rental,
  });

  @override
  State<RentalInfo> createState() => _RentalInfoState();
}

class _RentalInfoState extends State<RentalInfo> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          context.pushNamed(
            'RentalDetails',
            extra: <String, dynamic>{
              'rental': widget.rental,
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '₱${widget.rental?.price}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'for ${widget.rental?.duration} day${widget.rental!.duration! > 1 ? 's' : ''}',
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
                    'Pickup date:',
                  ),
                  Text(
                    '${DateFormat('MMM d, y').format(widget.rental!.startRental!)}',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Return Date:',
                  ),
                  Text(
                    '${DateFormat('MMM d, y').format(widget.rental!.endRental!)}',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
