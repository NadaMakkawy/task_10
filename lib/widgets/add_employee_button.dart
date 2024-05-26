import 'package:flutter/material.dart';

import 'add_employee_dialog.dart';

class AddEmployeeButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController genderController;
  final TextEditingController ageController;
  final Function() onPressedFn;

  const AddEmployeeButton({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.genderController,
    required this.ageController,
    required this.onPressedFn,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AddEmployeeDialog(
              formKey: formKey,
              nameController: nameController,
              genderController: genderController,
              ageController: ageController,
              onPressedFn: onPressedFn,
            );
          },
        );
      },
      tooltip: 'Add Employee',
      child: const Icon(Icons.add),
    );
  }
}
