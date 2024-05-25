import 'package:flutter/material.dart';

class FormModel {
  final InputDecoration inputDecoration;
  final TextEditingController controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final bool? autoCorrectBool;
  final bool? obsecureBool;
  final int? max;
  final Function(String)? onChanged;

  const FormModel({
    required this.inputDecoration,
    required this.controller,
    required this.textInputType,
    required this.textInputAction,
    this.validator,
    this.autoCorrectBool,
    this.obsecureBool,
    this.max,
    this.onChanged,
  });
}
