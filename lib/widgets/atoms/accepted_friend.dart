import 'package:flutter/material.dart';

class AcceptedFriendAtom extends StatelessWidget {
  final String? name;
  const AcceptedFriendAtom({
    super.key,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
          child: Container(
            width: 32.0,
            height: 32.0,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              'assets/images/User_01c_(1).png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          name!,
        ),
      ],
    );
  }
}
