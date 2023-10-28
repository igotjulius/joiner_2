import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_theme.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_widgets.dart';
import 'package:joiner_1/pages/sign_up_page/sign_up_model.dart';
import 'package:joiner_1/widgets/molecules/cra_sign_up_mole.dart';
import 'package:joiner_1/widgets/molecules/user_sign_up_mole.dart';

class SignUpPageWidget extends StatefulWidget {
  const SignUpPageWidget({super.key});

  @override
  State<SignUpPageWidget> createState() => _SignUpPageWidgetState();
}

class _SignUpPageWidgetState extends State<SignUpPageWidget>
    with TickerProviderStateMixin {
  late SignUpPageModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignUpPageModel());
    _model.tabController ??= TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Become a Joiner',
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                fontFamily: 'Open Sans',
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        TextButton(
                          child: Text(
                            'Login',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .copyWith(
                                  color: FlutterFlowTheme.of(context).primary,
                                ),
                          ),
                          onPressed: () {
                            context.goNamed('Login');
                          },
                        ),
                      ],
                    ),
                    Text(
                      'Just fill in all the details.',
                      style:
                          FlutterFlowTheme.of(context).headlineSmall.override(
                                fontFamily: 'Open Sans',
                                fontSize: 12.0,
                                fontWeight: FontWeight.normal,
                              ),
                    ),
                  ],
                ),
              ),
              TabBar(
                controller: _model.tabController,
                onTap: (value) {
                  _model.tabController?.index = value;
                },
                tabs: [
                  Text(
                    'Joiner',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Rent your car',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _model.tabController,
                  children: [
                    wrapWithModel(
                      model: _model.userModel,
                      child: UserSignUpMole(),
                      updateCallback: () => setState(() {}),
                    ),
                    wrapWithModel(
                      model: _model.craModel,
                      child: CRASignUpMole(),
                      updateCallback: () => setState(() {}),
                    ),
                  ],
                ),
              ),
              FFButtonWidget(
                onPressed: () {
                  _model.signUp();
                },
                text: 'Sign Up',
                options: FFButtonOptions(
                  height: 40.0,
                  padding: EdgeInsetsDirectional.fromSTEB(40.0, 0.0, 40.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Roboto Flex',
                        color: Colors.white,
                      ),
                  elevation: 3.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              Text(
                'By signing up you accept Joiner’s Terms of Use and Privacy Policy.',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Roboto Flex',
                      fontSize: 12.0,
                      fontStyle: FontStyle.italic,
                    ),
              ),
            ].divide(SizedBox(height: 20.0)).addToEnd(SizedBox(height: 20.0)),
          ),
        ),
      ),
    );
  }
}
