import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';

class CRARentalInfo extends StatefulWidget {
  final String? name;
  final int? duration;
  final double? amount;
  const CRARentalInfo({super.key, this.name, this.duration, this.amount});

  @override
  State<CRARentalInfo> createState() => _CRARentalInfoState();
}

class _CRARentalInfoState extends State<CRARentalInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/User_01c_(1).png',
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name!),
                  Text(widget.duration.toString()),
                ],
              ),
            ].divide(
              SizedBox(
                width: 8,
              ),
            ),
          ),
          Text("${widget.amount}"),
        ],
      ),
    );
  }
}
