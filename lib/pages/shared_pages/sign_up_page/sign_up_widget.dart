import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_theme.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_widgets.dart';
import 'package:joiner_1/pages/shared_pages/sign_up_page/sign_up_model.dart';
import 'package:joiner_1/widgets/molecules/cra_sign_up_mole.dart';
import 'package:joiner_1/widgets/molecules/user_sign_up_mole.dart';

class SignUpPageWidget extends StatefulWidget {
  const SignUpPageWidget({super.key});

  @override
  State<SignUpPageWidget> createState() => _SignUpPageWidgetState();
}

class _SignUpPageWidgetState extends State<SignUpPageWidget>
    with TickerProviderStateMixin {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
        child: Padding(
          padding: EdgeInsetsDirectional.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Become a Joiner',
                        style:
                            FlutterFlowTheme.of(context).headlineSmall.override(
                                  fontFamily: 'Open Sans',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
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
                  TextButton(
                    child: Text(
                      'Login',
                      style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                            color: FlutterFlowTheme.of(context).primary,
                          ),
                    ),
                    onPressed: () {
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
                    wrapWithModel(
                      model: _model.userModel,
                      child: UserSignUpMole(
                        formKey: formKey,
                      ),
                      updateCallback: () => setState(() {}),
                    ),
                    wrapWithModel(
                      model: _model.craModel,
                      child: CraSignUpMole(),
                      updateCallback: () => setState(() {}),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      'By signing up you accept Joiner’s Terms of Use and Privacy Policy.',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Roboto Flex',
                            fontSize: 12.0,
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.transparent,
                            behavior: SnackBarBehavior.floating,
                            elevation: 4,
                            padding: EdgeInsets.zero,
                            content: ClipPath(
                              clipper: ShapeBorderClipper(
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Container(
                                height: 56,
                                decoration: BoxDecoration(
                                  color: Colors.green[600],
                                ),
                                child: Center(child: Text('Form submitted')),
                              ),
                            ),
                          ),
                        );
                        // _model.signUp();
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
    );
  }

  FFButtonWidget newMethod(BuildContext context) {
    return FFButtonWidget(
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        if (formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.transparent,
              behavior: SnackBarBehavior.floating,
              elevation: 4,
              padding: EdgeInsets.zero,
              content: ClipPath(
                clipper: ShapeBorderClipper(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.green[600],
                  ),
                  child: Center(child: Text('Form submitted')),
                ),
              ),
            ),
          );
          // _model.signUp();
        }
      },
      text: 'Sign Up',
      options: FFButtonOptions(
        height: 40.0,
        padding: EdgeInsetsDirectional.fromSTEB(40.0, 0.0, 40.0, 0.0),
        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
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
    );
  }
}
