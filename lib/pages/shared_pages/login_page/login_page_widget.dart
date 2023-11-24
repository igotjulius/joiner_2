import '/flutter_flow/flutter_flow_util.dart';
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

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginPageModel());

    _model.textController1 ??= TextEditingController();
    _model.textController2 ??= TextEditingController();
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
      key: scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            'Discover Unseen Beauty',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        Text(
                          'Your adventure awaits',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        TextFormField(
                          controller: _model.textController1,
                          autofocus: true,
                          decoration: InputDecoration(
                            labelText: 'Email',
                          ),
                          style: Theme.of(context).textTheme.bodySmall,
                          validator: _model.textController1Validator
                              .asValidator(context),
                        ),
                        TextFormField(
                          controller: _model.textController2,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                          ),
                          style: Theme.of(context).textTheme.bodySmall,
                          validator: _model.textController2Validator
                              .asValidator(context),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: _model.isCra,
                                  side: BorderSide(width: 1),
                                  onChanged: (val) {
                                    setState(() {
                                      _model.setIsCra(val!);
                                    });
                                  },
                                ),
                                Text(
                                  'Login as Car Rental Agent',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                            Text(
                              'Forgot password?',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ].divide(SizedBox(height: 10.0)),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: FilledButton(
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
                              await _model.loginUser(context);
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
                                context.pushNamed('Sign Up');
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
                Spacer(),
                Text(
                  'Copyright 2023',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
