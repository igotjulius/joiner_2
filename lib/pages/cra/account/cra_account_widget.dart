import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_widgets.dart';
import 'package:joiner_1/pages/cra/account/cra_account_model.dart';

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
    return Center(
      child: FFButtonWidget(
        text: 'Logout',
        onPressed: () {
          _model.logout(context);
        },
        options: FFButtonOptions(height: 40),
      ),
    );
  }
}
