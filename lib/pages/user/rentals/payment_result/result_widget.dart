import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget {
  final String? result;
  const ResultWidget({super.key, this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment $result'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              Image.asset(
                'assets/images/$result-payment.png',
                height: 200,
                width: 200,
              ),
              SizedBox(
                height: 40,
              ),
              Text('Payment $result'),
            ],
          ),
        ),
      ),
    );
  }
}
