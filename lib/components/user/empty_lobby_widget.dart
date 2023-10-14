import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'empty_lobby_model.dart';
export 'empty_lobby_model.dart';

class EmptyLobbyWidget extends StatefulWidget {
  const EmptyLobbyWidget({Key? key}) : super(key: key);

  @override
  _EmptyLobbyWidgetState createState() => _EmptyLobbyWidgetState();
}

class _EmptyLobbyWidgetState extends State<EmptyLobbyWidget> {
  late EmptyLobbyModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptyLobbyModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No trips being planned at the moment.',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Roboto Flex',
                  color: FlutterFlowTheme.of(context).accent4,
                ),
          ),
          FFButtonWidget(
            onPressed: () async {
              context.pushNamed(
                'BrowseMap',
                extra: <String, dynamic>{
                  kTransitionInfoKey: TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.rightToLeft,
                  ),
                },
              );
            },
            text: 'Discover places',
            options: FFButtonOptions(
              height: 40.0,
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
              color: FlutterFlowTheme.of(context).primary,
              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: 'Open Sans',
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
              elevation: 3.0,
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ].divide(SizedBox(height: 10.0)),
      ),
    );
  }
}
