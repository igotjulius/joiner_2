import 'package:go_router/go_router.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/models/helpers/user.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountWidget extends StatefulWidget {
  const AccountWidget({super.key});

  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  final _passFormKey = GlobalKey<FormState>();
  late User _currentUser;
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _nPassController = TextEditingController();
  String? _errorText;

  void _resetController() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _passController = TextEditingController();
    _nPassController = TextEditingController();
    _errorText = null;
  }

  @override
  Widget build(BuildContext context) {
    _currentUser = context.watch<Auth>().profile!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/User_05c_(1).png',
                  width: 65,
                  height: 65,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "${_currentUser.firstName} ${_currentUser.lastName[0]}.",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    _editDetails();
                  },
                  icon: Icon(Icons.edit_rounded),
                ),
              ],
            ),
            _details(),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                _changePassword(),
                _logout(),
              ].divide(
                SizedBox(
                  height: 10,
                ),
              ),
            ),
          ].divide(
            SizedBox(
              height: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _details() {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'First name',
              style: textTheme.titleMedium,
            ),
            Text(
              _currentUser.firstName,
              style:
                  textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Divider(
          indent: 4,
          endIndent: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Last name',
              style: textTheme.titleMedium,
            ),
            Text(
              "${_currentUser.lastName}",
              style:
                  textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Divider(
          indent: 4,
          endIndent: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Email',
              style: textTheme.titleMedium,
            ),
            Text(
              "${_currentUser.email}",
              style:
                  textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ].divide(
        SizedBox(
          height: 4,
        ),
      ),
    );
  }

  Future _editDetails() {
    _firstNameController.text = _currentUser.firstName;
    _lastNameController.text = _currentUser.lastName;
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextInput(
                    label: 'First name',
                    controller: _firstNameController,
                    validator: isEmpty,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextInput(
                    label: 'Last name',
                    controller: _lastNameController,
                    validator: isEmpty,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: FilledButton(
                      onPressed: () async {
                        if(_firstNameController.text.isEmpty || _lastNameController.text.isEmpty) {return;}
                        showDialogLoading(context);
                        final result = await context.read<Auth>().editAccount(
                            _firstNameController.text,
                            _lastNameController.text);
                        context.pop();
                        if (result) {
                          context.pop();
                          _resetController();
                          ScaffoldMessenger.of(context).showSnackBar(
                            showSuccess('Profile Saved'),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            showError('Can\'t edit profile :(',
                                Theme.of(context).colorScheme.error),
                          );
                        }
                      },
                      child: Text('Save'),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _changePassword() {
    return TextButton.icon(
      style: TextButton.styleFrom(
        minimumSize: Size.fromHeight(10),
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(builder: (context, setState) {
                return Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _passFormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextInput(
                            label: 'Enter current password',
                            controller: _passController,
                            obscureText: true,
                            errorText: _errorText,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (_) => {
                              setState(() {
                                _errorText = null;
                              })
                            },
                          ),
                          SizedBox(height: 4),
                          CustomTextInput(
                            label: 'Enter new password',
                            controller: _nPassController,
                            obscureText: true,
                            validator: validatePassword,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            child: FilledButton(
                              onPressed: () async {
                                if (_passFormKey.currentState!.validate()) {
                                  showDialogLoading(context);
                                  final result = await (context.read<Auth>())
                                      .changePassword(_passController.text,
                                          _nPassController.text);
                                  context.pop();
                                  if (result) {
                                    context.pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      showSuccess('Password changed'),
                                    );
                                    _resetController();
                                  } else {
                                    setState(() {
                                      _errorText = 'Passwords don\'t match';
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      showError('Can\'t change password :(',
                                          Theme.of(context).colorScheme.error),
                                    );
                                  }
                                }
                              },
                              child: Text('Change'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
            });
      },
      icon: Icon(Icons.lock_reset_rounded),
      label: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Change password',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }

  Widget _logout() {
    return TextButton.icon(
      onPressed: () {
        showDialogLoading(context);
        context.read<AuthController>().logout().then((value) {
          context.pop();
          if (!value)
            ScaffoldMessenger.of(context).showSnackBar(
              showError(
                  'Can\'t logout :(', Theme.of(context).colorScheme.error),
            );
        });
      },
      icon: Icon(Icons.logout),
      label: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Logout',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
