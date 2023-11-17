import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';

class CustomTextInput extends StatefulWidget {
  final String? initialValue;
  final String? label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputFormatter inputFormatters;
  final bool enabled;
  final bool obscureText;
  final bool readOnly;
  final Icon? prefixIcon;

  CustomTextInput({
    super.key,
    this.initialValue,
    this.label,
    this.controller,
    this.validator,
    this.keyboardType,
    TextInputFormatter? inputFormatters,
    this.enabled = true,
    this.obscureText = false,
    this.readOnly = false,
    this.prefixIcon,
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
            if (widget.label != null)
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.label!,
                ),
              ),
            TextFormField(
              readOnly: widget.readOnly,
              initialValue: widget.initialValue,
              controller: widget.controller,
              validator: widget.validator,
              keyboardType: widget.keyboardType,
              enabled: widget.enabled,
              obscureText: widget.obscureText,
              inputFormatters: [
                widget.inputFormatters,
              ],
              decoration: InputDecoration(
                prefixIcon: widget.prefixIcon,
                border: OutlineInputBorder(),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ),
          ].divide(
            SizedBox(
              height: 4,
            ),
          ),
        ),
      ],
    );
  }
}
