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
  TextEditingController _addressController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
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
    return SafeArea(
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Account',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
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
                        editDetails();
                      },
                      icon: Icon(Icons.edit_rounded),
                    ),
                  ],
                ),
                accountDetails(),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    changePassword(),
                    logout(),
                  ].divide(
                    SizedBox(
                      height: 10,
                    ),
                  ),
                ),
                SizedBox(
                  height: 64,
                ),
              ].divide(
                SizedBox(
                  height: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget accountDetails() {
    return Column(
      children: [
        details('First name', _currentUser.firstName),
        details('Last name', _currentUser.lastName),
        details('Email', _currentUser.email),
        details('Address', _currentUser.address),
        details('Contact no.', _currentUser.contactNo),
      ].divide(
        Divider(),
      ),
    );
  }

  Widget details(String label, String? content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          '$content',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Future editDetails() {
    _firstNameController.text = _currentUser.firstName;
    _lastNameController.text = _currentUser.lastName;
    _addressController.text = _currentUser.address;
    _contactController.text = _currentUser.contactNo;
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextInput(
                      label: 'First name',
                      controller: _firstNameController,
                      validator: isEmpty,
                    ),
                    CustomTextInput(
                      label: 'Last name',
                      controller: _lastNameController,
                      validator: isEmpty,
                    ),
                    CustomTextInput(
                      label: 'Address',
                      controller: _addressController,
                      validator: isEmpty,
                    ),
                    CustomTextInput(
                      label: 'Contact no.',
                      controller: _contactController,
                      validator: validateMobile,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: FilledButton(
                        onPressed: () async {
                          if (_firstNameController.text.isEmpty ||
                              _lastNameController.text.isEmpty) {
                            return;
                          }
                          showDialogLoading(context);
                          final result = await context.read<Auth>().editAccount(
                                _firstNameController.text.trim(),
                                _lastNameController.text.trim(),
                                _addressController.text.trim(),
                                _contactController.text.trim(),
                              );
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
                  ].divide(
                    SizedBox(
                      height: 10,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget changePassword() {
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
                                      .changePassword(
                                    _passController.text.trim(),
                                    _nPassController.text.trim(),
                                  );
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

  Widget logout() {
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
