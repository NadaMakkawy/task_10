import 'package:flutter/material.dart';

import '../widgets/fields_list.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final formKey = GlobalKey<FormState>();

  String? employeeName;

  var employeeNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          const Expanded(
            child: FieldsList(),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.person_2_outlined,
                      size: 32,
                      color: Colors.cyan,
                    ),
                    onPressed: () {},
                  ),
                  OutlinedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        employeeName = employeeNameController.text;
                        setState(() {});
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Colors.cyan,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      'Add Employee',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.cyan,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (employeeName != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                '$employeeName has been successfully added to the employee list',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
