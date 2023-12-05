import 'package:joiner_1/models/user_model.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'account_model.dart';
export 'account_model.dart';

class AccountWidget extends StatefulWidget {
  const AccountWidget({Key? key}) : super(key: key);

  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  late AccountModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _model = createModel(context, () => AccountModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _model.currentUser = context.watch<FFAppState>().currentUser as UserModel;

    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        top: true,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white//Color(0xFF0B443A),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0.0),
                      child: Image.asset(
                        'assets/images/prof-bg.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 1.0),
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 0.7,
                        child: Stack(
                          alignment: AlignmentDirectional(0.0, 1.0),
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 110.0, 0.0, 0.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(0.0),
                                    bottomRight: Radius.circular(0.0),
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                         Image.asset(
                                            'assets/images/User_05c_(1).png',
                                            width: 65,
                                            height: 65,
                                            fit: BoxFit.fill,
                                          ),
                                          SizedBox(width: 20,),
                                          Text(
                                            "${_model.currentUser?.firstName} ${_model.currentUser?.lastName?[0]}.",
                                            style: Theme.of(context).textTheme.displaySmall
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        thickness: 1.0,
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'First name',
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          8.0, 0.0, 8.0, 0.0),
                                                  child: Container(
                                                    width: 160.0,
                                                    child: Text(
                                                      _model.currentUser!
                                                          .firstName!,
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Last name',
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          8.0, 0.0, 8.0, 0.0),
                                                  child: Container(
                                                    width: 160.0,
                                                    child: Text(
                                                      "${_model.currentUser?.lastName}",
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Email',
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          8.0, 0.0, 8.0, 0.0),
                                                  child: Text(
                                                    "${_model.currentUser?.email}",
                                                    textAlign:
                                                        TextAlign.right,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]
                                            .addToStart(SizedBox(height: 10.0))
                                            .addToEnd(SizedBox(height: 10.0)),
                                      ),
                                      Divider(
                                        thickness: 1.0,
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          if (Navigator.of(context).canPop()) {
                                            context.pop();
                                          }
                                          _model.logout(context);
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(
                                              Icons.logout,
                                              size: 30,
                                            ),
                                            SizedBox(width: 10,),
                                            Text('Logout'),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1.0,
                                      ),
                                    ].addToStart(SizedBox(height: 40.0)),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.0, -1.0),
                              child: Container(
                                width: 72.0,
                                height: 72.0,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      2.0, 2.0, 2.0, 2.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
