import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/pages/shared_pages/sign_up_page/sign_up_model.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:joiner_1/widgets/molecules/cra_sign_up_mole.dart';
import 'package:joiner_1/widgets/molecules/user_sign_up_mole.dart';
import 'package:provider/provider.dart';

class SignUpPageWidget extends StatefulWidget {
  const SignUpPageWidget({super.key});

  @override
  State<SignUpPageWidget> createState() => _SignUpPageWidgetState();
}

class _SignUpPageWidgetState extends State<SignUpPageWidget>
    with TickerProviderStateMixin {
  GlobalKey<FormState> joinerFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> rentFormKey = GlobalKey<FormState>();
  late SignUpPageModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignUpPageModel());
    _model.userModel = createModel(context, () => UserSignUpMoleModel());
    _model.tabController ??= TabController(length: 2, vsync: this);
    _model.craModel = createModel(context, () => CraSignUpMoleModel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsetsDirectional.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Create an Account',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      child: Text(
                        'Login Now',
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        context.goNamed('Login');
                      },
                    ),
                  ],
                ),
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.blue,
                    ),
                  ),
                  child: TabBar(
                    splashBorderRadius: BorderRadius.circular(20),
                    labelPadding: EdgeInsets.symmetric(vertical: 8),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.blue[300],
                    indicator: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    controller: _model.tabController,
                    onTap: (value) {
                      _model.tabController?.index = value;
                    },
                    tabs: [
                      Text(
                        'Joiner',
                      ),
                      Text(
                        'Rent your car',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _model.tabController,
                    children: [
                      Provider.value(
                        value: _model.userModel,
                        child: UserSignUpMole(
                          formKey: joinerFormKey,
                        ),
                      ),
                      Provider.value(
                        value: _model.craModel,
                        child: CraSignUpMole(
                          formKey: rentFormKey,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 5,
                      child: Text(
                        'By signing up you accept Joiner\'s Terms of Use and Privacy Policy.',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontStyle: FontStyle.italic,
                            ),
                      ),
                    ),
                    Spacer(),
                    FilledButton.tonal(
                      onPressed: () {
                        final joinerForm = joinerFormKey.currentState != null &&
                            joinerFormKey.currentState!.validate();
                        final craForm = rentFormKey.currentState != null &&
                            rentFormKey.currentState!.validate();
                        if (joinerForm || craForm) {
                          showDialogLoading(context);
                          _model.signUp().then(
                            (value) {
                              if (value != null) {
                                context.pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  showError(value,
                                      Theme.of(context).colorScheme.error),
                                );
                                _model.userModel.emailError =
                                    'Email already in use';
                                setState(() {});
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  showSuccess('Registration successful'),
                                );
                                context.goNamed('Login');
                              }
                            },
                          );
                        }
                      },
                      child: Text('Sign Up'),
                    ),
                  ],
                ),
              ].divide(SizedBox(
                height: 20,
              )),
            ),
          ),
        ),
      ),
    );
  }
}
