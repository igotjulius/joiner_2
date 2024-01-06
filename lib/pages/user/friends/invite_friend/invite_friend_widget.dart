import 'dart:io';

import 'package:go_router/go_router.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class InviteFriendWidget extends StatefulWidget {
  const InviteFriendWidget({Key? key}) : super(key: key);

  @override
  _InviteFriendWidgetState createState() => _InviteFriendWidgetState();
}

class _InviteFriendWidgetState extends State<InviteFriendWidget> {
  TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'Invite your friend by sending an email to them.',
              ),
              CustomTextInput(
                label: 'Enter your friend\'s email',
                controller: _emailController,
                hintText: 'Your friend\'s email..',
                validator: validateEmail,
              ),
              FilledButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showDialogLoading(context);
                    (context.read<Auth>() as UserController)
                        .inviteFriend(_emailController.text.trim())
                        .then((value) {
                      context.pop();
                      if (value?.code == HttpStatus.ok) {
                        context.pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          showSuccess('Friend request sent'),
                        );
                      } else
                        ScaffoldMessenger.of(context).showSnackBar(
                          showError('${value?.message} :(',
                              Theme.of(context).colorScheme.error),
                        );
                    });
                  }
                },
                child: Text('Send friend request'),
              ),
            ].divide(SizedBox(height: 20.0)),
          ),
        ),
      ),
    );
  }
}
