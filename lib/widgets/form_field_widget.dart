import 'package:flutter/material.dart';

import '../models/form_model.dart';

class FormFieldWidget extends StatelessWidget {
  final FormModel formModel;
  const FormFieldWidget({super.key, required this.formModel});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: formModel.controller,
      validator: formModel.validator,
      keyboardType: formModel.textInputType,
      textInputAction: formModel.textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autocorrect: formModel.autoCorrectBool ?? false,
      decoration: formModel.inputDecoration,
      maxLength: formModel.max,
      obscureText: formModel.obsecureBool ?? false,
      onChanged: formModel.onChanged,
    );
  }
}

bool checker(String value, String check) => value.contains(check);

InputDecoration textFieldDecoration(
  BuildContext context, {
  Color? color,
  IconData? icon,
  String? hint,
  required String label,
}) {
  return InputDecoration(
    prefixIcon: Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Icon(
        icon,
        color: color,
      ),
    ),
    labelText: label,
    labelStyle: Theme.of(context).textTheme.labelMedium,
    hintText: hint,
    hintStyle:
        Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),
  );
}
