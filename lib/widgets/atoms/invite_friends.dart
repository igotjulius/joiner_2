import 'package:flutter/material.dart';
// ignore: unused_import
import 'dart:ui_web' as ui;

import 'package:joiner_1/flutter_flow/flutter_flow_widgets.dart';

class InviteFriends extends StatefulWidget {
  final String name;
  const InviteFriends({super.key, required this.name});

  @override
  State<InviteFriends> createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50.0,
                          height: 50.0,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/User_01c_(1).png',
                              width: 30,
                              height: 30,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.1),
                        Expanded(
                          child: Text(
                            '${widget.name} sent you a friend request',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Divider(
                          height: 12.0,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceEvenly, // Align buttons evenly
                          children: [
                            Expanded(
                              child: FFButtonWidget(
                                text: 'Decline',
                                onPressed: () {},
                                options: FFButtonOptions(
                                  width: 135.0,
                                  color: Colors.black38,
                                ),
                              ),
                            ),
                            Expanded(
                              child: FFButtonWidget(
                                text: 'Accept',
                                onPressed: () {},
                                options: FFButtonOptions(
                                  iconPadding: EdgeInsets.all(15.0),
                                  width: 135.0,
                                  color: Colors.green,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
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
