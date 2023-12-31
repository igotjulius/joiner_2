import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:joiner_1/utils/utils.dart';

enum TextInputDirection { row, column }

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
  final EdgeInsets? contentPadding;
  final bool? isDense;
  final TextInputDirection? direction;
  final Icon? suffixIcon;
  final TextStyle? labelStyle;
  final AutovalidateMode? autovalidateMode;

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
    this.contentPadding,
    this.isDense,
    this.direction = TextInputDirection.column,
    this.suffixIcon,
    this.labelStyle,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  }) : inputFormatters =
            inputFormatters ?? FilteringTextInputFormatter.singleLineFormatter;

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  Widget onRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            widget.label!,
            style: widget.labelStyle ?? Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Expanded(child: customTextField()),
      ],
    );
  }

  Widget onColumn() {
    return Column(
      children: [
        if (widget.label != null)
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              widget.label!,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        customTextField(),
      ].divide(
        SizedBox(
          height: 4,
        ),
      ),
    );
  }

  Widget customTextField() {
    return TextFormField(
      readOnly: widget.readOnly,
      initialValue: widget.initialValue,
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      enabled: widget.enabled,
      obscureText: widget.obscureText,
      autovalidateMode: widget.autovalidateMode,
      inputFormatters: [
        widget.inputFormatters,
      ],
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        hintText: widget.hintText,
        fillColor: widget.fillColor,
        filled: widget.fillColor == null ? false : true,
        enabledBorder:
            // widget.fillColor == null? null:
            OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        errorText: widget.errorText,
        contentPadding: widget.contentPadding,
        isDense: widget.isDense,
        suffixIcon: widget.suffixIcon,
      ),
      style: Theme.of(context).textTheme.bodySmall,
      onChanged: widget.onChanged,
    );
  }

  Widget content() {
    switch (widget.direction) {
      case TextInputDirection.column:
        return onColumn();
      case TextInputDirection.row:
        return onRow();
      default:
        return onColumn();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        content(),
      ],
    );
  }
}
