import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget {
  final String? result;
  const ResultWidget({super.key, this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text('Payment sent'),
            Image.asset(
              'assets/images/$result-payment.png',
              scale: 0.6,
            ),
          ],
        ),
      ),
    );
  }
}
