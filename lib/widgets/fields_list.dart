import 'package:flutter/material.dart';

import '../models/form_model.dart';
import 'form_field_widget.dart';

class FieldsList extends StatefulWidget {
  const FieldsList({super.key});

  @override
  State<FieldsList> createState() => _FieldsListState();
}

class _FieldsListState extends State<FieldsList> {
  var employeeNameController = TextEditingController();
  var genderController = TextEditingController();
  var ageController = TextEditingController();

  @override
  void dispose() {
    employeeNameController.dispose();
    genderController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            FormFieldWidget(
              formModel: FormModel(
                controller: employeeNameController,
                inputDecoration: textFieldDecoration(
                  context,
                  icon: Icons.person,
                  label: 'Employee Name',
                  hint: 'nada mostafa',
                ),
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.name,
                max: 12,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a valid name';
                  }
                  return null;
                },
              ),
            ),
            FormFieldWidget(
              formModel: FormModel(
                controller: genderController,
                inputDecoration: textFieldDecoration(
                  context,
                  icon: Icons.male_sharp,
                  label: 'Gender',
                  hint: 'male / female',
                ),
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty ||
                      !checker(value, 'male') && !checker(value, 'female')) {
                    return 'Please enter a valid gender';
                  }
                  return null;
                },
              ),
            ),
            FormFieldWidget(
              formModel: FormModel(
                controller: ageController,
                inputDecoration: textFieldDecoration(
                  context,
                  icon: Icons.numbers_sharp,
                  label: 'Age',
                ),
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty || checker(value, ' ')) {
                    return 'Please enter a valid age';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
