import 'dart:io';

import 'package:go_router/go_router.dart';
import 'package:joiner_1/app_state.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/user_model.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountWidget extends StatefulWidget {
  const AccountWidget({Key? key}) : super(key: key);

  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  late AccountModel _model;
  final _passFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = AccountModel();
  }

  @override
  Widget build(BuildContext context) {
    _model.currentUser = context.watch<FFAppState>().currentUser as UserModel;
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
                  "${_model.currentUser?.firstName} ${_model.currentUser?.lastName?[0]}.",
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
            details(),
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
          ].divide(
            SizedBox(
              height: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget details() {
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
              _model.currentUser!.firstName!,
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
              "${_model.currentUser?.lastName}",
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
              "${_model.currentUser?.email}",
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

  void editDetails() {
    showDialog(
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
                    controller: _model.firstNameController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextInput(
                    label: 'Last name',
                    controller: _model.lastNameController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: FilledButton(
                      onPressed: () async {
                        showDialogLoading(context);
                        final result = await _model.editProfile();

                        if (result != null) {
                          context.read<FFAppState>().updateProfile(result);
                          ScaffoldMessenger.of(context).showSnackBar(
                            showSuccess('Changes saved'),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            showError('Saving failed',
                                Theme.of(context).colorScheme.error),
                          );
                        }
                        _model.resetController();
                        context.pop();
                        context.pop();
                        setState(() {});
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
                            controller: _model.passController,
                            obscureText: true,
                            errorText: _model.errorText,
                          ),
                          SizedBox(height: 4),
                          CustomTextInput(
                            label: 'Enter new password',
                            controller: _model.nPassController,
                            obscureText: true,
                            validator: validatePassword,
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
                                  final result = await _model.changePassword();
                                  if (result) {
                                    context.pop();
                                    context.pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      showSuccess('Password changed'),
                                    );
                                    _model.resetController();
                                  } else {
                                    context.pop();
                                    setState(() {});
                                  }
                                }
                                print(_model.errorText);
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
        _model.logout(context);
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

class AccountModel {
  UserModel? currentUser;
  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  TextEditingController? passController;
  TextEditingController? nPassController;
  String? errorText;

  AccountModel() {
    firstNameController ??= TextEditingController();
    lastNameController ??= TextEditingController();
    passController ??= TextEditingController();
    nPassController ??= TextEditingController();
  }

  void resetController() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    passController = TextEditingController();
    nPassController = TextEditingController();
    errorText = null;
  }

  Future<UserModel?> editProfile() async {
    return await UserController.editProfile(
        firstNameController!.text, lastNameController!.text);
  }

  Future<bool> changePassword() async {
    final result = await UserController.changePassword(
        passController!.text, nPassController!.text);
    if (result.code == HttpStatus.ok)
      return true;
    else {
      errorText = result.message;
      return false;
    }
  }

  void logout(BuildContext context) {
    context.read<FFAppState>().setCurrentUser(null);
    context.goNamed('Login');
  }

  /// Additional helper methods are added here.
}
