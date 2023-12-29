import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/rental_model.dart';
import 'package:joiner_1/utils/utils.dart';

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
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          context.pushNamed(
            'RentalDetails',
            extra: widget.rental,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  withCurrency(
                    Text(
                      '${widget.rental?.price}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
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
                height: 32.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pickup date:',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '${DateFormat('MMM d, y').format(widget.rental!.startRental!)}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Return Date:',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '${DateFormat('MMM d, y').format(widget.rental!.endRental!)}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w500),
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
