import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';
import 'package:provider/provider.dart';

class VerificationWidget extends StatefulWidget {
  const VerificationWidget({super.key});

  @override
  State<VerificationWidget> createState() => _VerificationWidgetState();
}

class _VerificationWidgetState extends State<VerificationWidget> {
  TextEditingController _codeController = TextEditingController();
  String? _verificationError;
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
            CustomTextInput(
              controller: _codeController,
              errorText: _verificationError,
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  FilledButton(
                    onPressed: () {
                      showDialogLoading(context);
                      context
                          .read<AuthController>()
                          .verify(_codeController.text)
                          .then((value) {
                        context.pop();
                        if (!value) {
                          setState(() {
                            _verificationError = 'Invalid code';
                          });
                        }
                      });
                    },
                    child: Text('Verify'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        context.read<AuthController>().resendVerification();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        showSuccess('Email sent'),
                      );
                    },
                    child: Text(
                      'Resend code?',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
