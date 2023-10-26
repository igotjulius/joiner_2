import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_model.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_theme.dart';

class CustomTextInput extends StatefulWidget {
  final String? initialValue;
  final String label;
  final TextEditingController? controller;
  final String? Function(BuildContext, String?)? validator;
  final TextInputType? keyboardType;
  final TextInputFormatter inputFormatters;
  final bool enabled;

  CustomTextInput({
    super.key,
    this.initialValue,
    required this.label,
    this.controller,
    this.validator,
    this.keyboardType,
    TextInputFormatter? inputFormatters,
    this.enabled = true,
  }) : inputFormatters =
            inputFormatters ?? FilteringTextInputFormatter.singleLineFormatter;

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.label,
                style: FlutterFlowTheme.of(context)
                    .bodyMedium
                    .copyWith(color: Color(0xff7d7d7d)),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            TextFormField(
              initialValue: widget.initialValue,
              controller: widget.controller,
              validator: widget.validator.asValidator(context),
              keyboardType: widget.keyboardType,
              enabled: widget.enabled,
              inputFormatters: [
                widget.inputFormatters,
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
