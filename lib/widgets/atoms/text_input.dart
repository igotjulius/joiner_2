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
  final String? hintText;
  final String? errorText;
  final Color? fillColor;
  final void Function(String)? onChanged;

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
    this.hintText,
    this.errorText,
    this.fillColor,
    this.onChanged,
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
                  style: Theme.of(context).textTheme.titleSmall,
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
                hintText: widget.hintText,
                fillColor: widget.fillColor,
                filled: widget.fillColor == null ? false : true,
                enabledBorder: widget.fillColor == null
                    ? null
                    : OutlineInputBorder(
                        borderSide: BorderSide(color: widget.fillColor!),
                      ),
                errorText: widget.errorText,
              ),
              style: Theme.of(context).textTheme.bodySmall,
              onChanged: widget.onChanged,
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
