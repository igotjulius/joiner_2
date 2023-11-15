import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextInput extends StatefulWidget {
  final String? initialValue;
  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputFormatter inputFormatters;
  final bool enabled;
  final bool obscureText;

  CustomTextInput({
    super.key,
    this.initialValue,
    required this.label,
    this.controller,
    this.validator,
    this.keyboardType,
    TextInputFormatter? inputFormatters,
    this.enabled = true,
    this.obscureText = false,
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
              ),
            ),
            SizedBox(
              height: 4,
            ),
            TextFormField(
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
                border: OutlineInputBorder(),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
