import 'package:go_router/go_router.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:flutter/material.dart';
import 'login_page_model.dart';
export 'login_page_model.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  late LoginPageModel _model;
  String? _errorMessage;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _model = LoginPageModel();

    _model.emailController ??= TextEditingController();
    _model.passwordController ??= TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _model.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final gradient =
        LinearGradient(colors: [colorScheme.primary, colorScheme.tertiary]);
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (bounds) => gradient.createShader(
                              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                            ),
                            child: Text(
                              'Plan with ease',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ),
                          Text(
                            'For your group travels',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                      Flexible(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                  padding:
                                      EdgeInsets.only(top: 2.5, bottom: 2.5)),
                              TextFormField(
                                key: Key('emailField'),
                                controller: _model.emailController,
                                autofocus: true,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  errorText: _errorMessage,
                                ),
                                style: Theme.of(context).textTheme.bodySmall,
                                validator: _model.validateEmail,
                              ),
                              TextFormField(
                                key: Key('passwordField'),
                                controller: _model.passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  errorText: _errorMessage,
                                ),
                                style: Theme.of(context).textTheme.bodySmall,
                                validator: _model.validatePassword,
                              ),
                            ].divide(SizedBox(height: 10.0)),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: double.maxFinite,
                            child: FilledButton(
                              key: Key('loginButton'),
                              child: Text(
                                'LOGIN',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: Colors.white,
                                      letterSpacing: 3,
                                    ),
                              ),
                              onPressed: () async {
                                // TODO: if user is not yet verified, send a verification email and redirect to verification page
                                if (_formKey.currentState!.validate()) {
                                  showDialogLoading(context);
                                  final result =
                                      await _model.loginUser(context);
                                  if (!result) {
                                    context.pop();
                                    setState(() {
                                      _errorMessage =
                                          'Invalid username/password';
                                    });
                                  }
                                }
                                // context.goNamed('Verification');
                              },
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Not yet a Joiner?',
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  setState(() {
                                    // _errorMessage = null;
                                    _model.emailController?.clear();
                                    _model.passwordController?.clear();
                                    context.pushNamed('Sign Up');
                                  });
                                },
                                child: Text(
                                  'Join now!',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ),
                            ].divide(SizedBox(width: 4.0)),
                          ),
                        ].divide(SizedBox(height: 8.0)),
                      ),
                    ].divide(
                      SizedBox(
                        height: 56,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
