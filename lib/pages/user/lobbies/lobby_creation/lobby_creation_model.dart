import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class LobbyCreationModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  DateTimeRange? datePicked;
  // State field(s) for Checkbox widget.
  bool? checkboxValue1;
  // State field(s) for Checkbox widget.
  bool? checkboxValue2;
  // State field(s) for Checkbox widget.
  bool? checkboxValue3;
  // State field(s) for Checkbox widget.
  bool? checkboxValue4;

  // State field(s) for TextField widget.
  TextEditingController? titleInput;
  String? Function(BuildContext, String?)? titleInputValidator;
  // State field(s) for TextField widget.
  TextEditingController? descInput;
  String? Function(BuildContext, String?)? descInputValidator;
  // State field(s) for TextField widget.
  TextEditingController? budgetInput;
  String? Function(BuildContext, String?)? budgetInputValidator;
  // State field(s) for TextField widget.
  TextEditingController? meetingInput;
  String? Function(BuildContext, String?)? meetingInputValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    titleInput?.dispose();
    descInput?.dispose();
    budgetInput?.dispose();
    meetingInput?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}