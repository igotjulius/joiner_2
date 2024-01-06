import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
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
  final _userModel = UserSignUpMoleModel();
  final _craModel = CraSignUpMoleModel();
  late TabController _tabController;
  final _tabs = [
    Tab(
      text: 'Joiner',
    ),
    Tab(
      text: 'Rent your car',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _userModel.dispose();
    _craModel.dispose();
    _tabController.dispose();
    super.dispose();
  }

  AppBar appBar() => AppBar(
        title: Text(
          'Create an Account',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
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
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.blue[300],
                    indicator: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    controller: _tabController,
                    onTap: (value) {
                      _tabController.index = value;
                    },
                    tabs: _tabs,
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Provider.value(
                        value: _userModel,
                        child: UserSignUpMole(
                          formKey: joinerFormKey,
                        ),
                      ),
                      Provider.value(
                        value: _craModel,
                        child: CraSignUpMole(
                          formKey: rentFormKey,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 5,
                        child: Text(
                          'By signing up you accept Joiner\'s Terms of Use and Privacy Policy.',
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
                        ),
                      ),
                      Spacer(),
                      FilledButton(
                        onPressed: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          final joinerForm =
                              joinerFormKey.currentState != null &&
                                  joinerFormKey.currentState!.validate();
                          final craForm = rentFormKey.currentState != null &&
                              rentFormKey.currentState!.validate();
                          if (joinerForm || craForm) {
                            showDialogLoading(context);
                            final result = joinerForm
                                ? await context
                                    .read<AuthController>()
                                    .registerUser(_userModel.getUserInput())
                                : await context
                                    .read<AuthController>()
                                    .registerCra(_craModel.getUserInput());
                            context.pop();
                            if (result != null) {
                              setState(() {
                                if (joinerFormKey.currentState != null) {
                                  _userModel.emailError =
                                      'Email already in use';
                                }
                                if (rentFormKey.currentState != null) {
                                  _craModel.emailError = 'Email already in use';
                                }
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                showSuccess('Registration successful'),
                              );
                              context.goNamed('Login');
                            }
                          }
                        },
                        child: Text('Sign Up'),
                      ),
                    ],
                  ),
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
