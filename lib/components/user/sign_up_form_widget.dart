import 'package:joiner_1/service/api_service.dart';
import 'package:joiner_1/widgets/molecules/cra_sign_up_mole.dart';
import 'package:joiner_1/widgets/molecules/user_sign_up_mole.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sign_up_form_model.dart';
export 'sign_up_form_model.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({Key? key}) : super(key: key);

  @override
  _SignUpFormWidgetState createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget>
    with TickerProviderStateMixin {
  late SignUpFormModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignUpFormModel());

    _model.textController1 ??= TextEditingController();
    _model.textController2 ??= TextEditingController();
    _model.textController3 ??= TextEditingController();
    _model.textController4 ??= TextEditingController();
    _model.textController5 ??= TextEditingController();

    _model.tabController ??= TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    FutureBuilder<String> _signUp() {
      final user = {'firstName': _model.textController1.text};
      return FutureBuilder(
        future: apiService.registerUser(user),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String signUpResult = snapshot.data!;
            return Dialog(
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      signUpResult,
                    ),
                  )
                ],
              ),
            );
          } else {
            return Dialog(child: SizedBox.shrink());
          }
        },
      );
    }

    return Material(
      color: Colors.transparent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: Container(
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
          padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional(1.0, -1.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 20.0, 0.0),
                  child: FlutterFlowIconButton(
                    borderRadius: 0.0,
                    borderWidth: 1.0,
                    buttonSize: 40.0,
                    icon: Icon(
                      Icons.close,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Text(
                'Become a Joiner',
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                      fontFamily: 'Open Sans',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                'Just fill in all the details.',
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                      fontFamily: 'Open Sans',
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                    ),
              ),
              TabBar(
                controller: _model.tabController,
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
                    UserSignUpMole(),
                    CraSignUpMole(),
                  ],
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return _signUp();
                    },
                  );
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
