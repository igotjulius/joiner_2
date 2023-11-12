import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';

class CancelledWidget extends StatelessWidget {
  const CancelledWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          iconSize: 32,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
          onPressed: () async {
            context.pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset('assets/images/cancelled-payment.png'),
            Text('Payment Cancelled.'),
          ],
        ),
      ),
    );
  }
}
