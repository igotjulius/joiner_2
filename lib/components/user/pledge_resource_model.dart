import 'package:flutter/material.dart';

class PledgeResourceModel {
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  void initState(BuildContext context) {}

  void dispose() {
    textController?.dispose();
  }
}
