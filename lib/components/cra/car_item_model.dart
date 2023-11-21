import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_model.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';

class CarItemModel extends FlutterFlowModel {
  TextEditingController? priceInput;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    priceInput?.dispose();
  }
}
