import 'package:flutter/material.dart';

import 'package:joiner_1/flutter_flow/flutter_flow_widgets.dart';

class PendingFriendAtom extends StatelessWidget {
  final String? name;
  final String? friendId;
  final Function(String)? eventAction;
  const PendingFriendAtom(
      {super.key, this.name, this.friendId, this.eventAction});

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
                            '$name sent you a friend request',
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
                                onPressed: () {
                                  eventAction!(friendId!);
                                },
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
