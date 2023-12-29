import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VerificationWidget extends StatefulWidget {
  const VerificationWidget({super.key});

  @override
  State<VerificationWidget> createState() => _VerificationWidgetState();
}

class _VerificationWidgetState extends State<VerificationWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verification Code',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        leading: IconButton(
          onPressed: () {
            context.goNamed('Login');
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter the verification code sent to your email address',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: FilledButton(
                onPressed: () {},
                child: Text('Verify'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
