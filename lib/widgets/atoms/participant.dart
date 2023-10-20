import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_theme.dart';

class ParticipantsAtom extends StatefulWidget {
  final String? name;
  const ParticipantsAtom(this.name, {super.key});

  @override
  State<ParticipantsAtom> createState() => _ParticipantsAtomState();
}

class _ParticipantsAtomState extends State<ParticipantsAtom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 10.0, 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/User_05c_(1).png',
                    width: 32.0,
                    height: 32.0,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Text(
                widget.name!,
                style: FlutterFlowTheme.of(context).bodyMedium,
              ),
            ],
          ),
          Checkbox(
              value: false,
              onChanged: (value) {
                // setState(() {});
              })
        ],
      ),
    );
  }
}
