import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_theme.dart';

class PollChoices extends StatelessWidget {
  final String? choice;
  final int? count;
  const PollChoices({super.key, this.choice, this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(8.0, 10.0, 8.0, 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              choice!,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Roboto Flex',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Text(
              "${count} votes",
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Roboto Flex',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
