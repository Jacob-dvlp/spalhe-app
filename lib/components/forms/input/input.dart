// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:spalhe/theme/colors.dart';

class Input extends StatelessWidget {
  final onSaved,
      hint,
      prefixIcon,
      suffixIcon,
      validator,
      keyboardType,
      disabled,
      obscureText,
      maskFilter,
      mask,
      onChanged,
      initialValue,
      maxLines,
      label,
      fillColor,
      controller;

  const Input({
    Key? key,
    required this.hint,
    this.prefixIcon,
    this.disabled,
    this.onSaved,
    this.validator,
    this.keyboardType,
    this.obscureText,
    this.mask,
    this.maskFilter,
    this.suffixIcon,
    this.onChanged,
    this.initialValue,
    this.maxLines,
    this.label,
    this.fillColor,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maskFormatter = MaskTextInputFormatter(
      mask: mask,
      filter: maskFilter ?? {"#": RegExp(r'[0-9]')},
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          inputFormatters: [maskFormatter],
          onSaved: onSaved,
          maxLines: maxLines ?? 1,
          onChanged: onChanged,
          obscureText: obscureText ?? false,
          enabled: disabled != true,
          keyboardType: keyboardType,
          initialValue: initialValue,
          scrollPadding: const EdgeInsets.all(0),
          decoration: InputDecoration(
            focusColor: primary,
            hoverColor: primary,
            hintText: hint,
            filled: true,
            fillColor: fillColor ?? Colors.white,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            labelText: label,
          ),
          validator: validator,
          style: TextStyle(
            color: disabled == true ? Colors.grey[400] : Colors.grey[400],
          ),
        ),
      ],
    );
  }
}
