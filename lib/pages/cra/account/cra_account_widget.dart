import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/cra_user_model.dart';
import 'package:joiner_1/pages/cra/account/cra_account_model.dart';
import 'package:provider/provider.dart';

class CraAccountWidget extends StatefulWidget {
  const CraAccountWidget({super.key});

  @override
  State<CraAccountWidget> createState() => _CraAccountWidgetState();
}

class _CraAccountWidgetState extends State<CraAccountWidget> {
  late CraAccountModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CraAccountModel());
  }


  @override
  Widget build(BuildContext context) {
    _model.craUser = context.watch<FFAppState>().currentUser as CraUserModel;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/User_01c_(1).png',
                        height: 100.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text('Edit Photo'),
            Text("${_model.craUser.firstName} ${_model.craUser.lastName}"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0),
                      borderRadius: BorderRadius.circular(8.0)),
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Upcoming Payout'),
                      Text('-'),
                      Text('- successful bookings'),
                      Divider(),
                      Text('Payout to be recieved on or before: -'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.0, color: Colors.blue),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.error,
                                      color: Colors.blue,
                                      size: 24.0,
                                    ),
                                    SizedBox(
                                      width: 3.0,
                                    ),
                                    Text(
                                        'Payout schedule is weekly on every Sunday'),
                                  ],
                                ),
                              ],
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Rating'),
                          Text('-'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Contact no.'),
                          Text('-'),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.key_sharp,
                              color: Colors.grey,
                              size: 24.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text('Change Password'),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.account_box,
                              color: Colors.grey,
                              size: 24.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text('Account Settings'),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.help_center,
                              color: Colors.grey,
                              size: 24.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text('Help Center'),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                  Divider(),
                  InkWell(
                    onTap: () {
                      _model.logout(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.logout,
                                color: Colors.grey,
                                size: 24.0,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('Logout'),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
