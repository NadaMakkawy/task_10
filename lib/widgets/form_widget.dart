import 'package:flutter/material.dart';
import 'package:task_10_test/pages/employee_page.dart';

import '../models/employee.dart';
import '../widgets/fields_list.dart';

class FormWidget extends StatefulWidget {
  final String title;
  final List<Employee> employeeList;

  const FormWidget({
    super.key,
    required this.employeeList,
    required this.title,
  });

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final formKey = GlobalKey<FormState>();

  String? employeeName;

  var employeeNameController = TextEditingController();
  var genderController = TextEditingController();
  var ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FieldsList fieldsList = FieldsList(
      employeeNameController: employeeNameController,
      genderController: genderController,
      ageController: ageController,
    );

    return Form(
      key: formKey,
      child: Column(
        children: [
          Expanded(
            child: FieldsList(
              employeeNameController: employeeNameController,
              genderController: genderController,
              ageController: ageController,
            ),
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
                        employeeName = fieldsList.employeeNameController.text;
                        if (formKey.currentState!.validate()) {
                          var emp = Employee(
                            name: fieldsList.employeeNameController.text,
                            gender: fieldsList.genderController.text,
                            age: int.parse(fieldsList.ageController.text),
                          );

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EmployeePage(
                                title: widget.title,
                                employeeList: [emp, ...widget.employeeList],
                                // employeeList: newEmployees(
                                //   fieldsList.employeeNameController.text,
                                //   fieldsList.genderController.text,
                                //   int.parse(fieldsList.ageController.text),
                                // ),
                              ),
                            ),
                            (route) => false,
                          );
                        }
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

  // List<Employee> newEmployees(String name, String gender, int age) {
  //   List<Employee> employeeList = widget.employeeList;
  //   FieldsList fieldsList = FieldsList(
  //     employeeNameController: employeeNameController,
  //     genderController: genderController,
  //     ageController: ageController,
  //   );

  //   final newEmployee = Employee(
  //     name: fieldsList.employeeNameController.text,
  //     gender: fieldsList.genderController.text,
  //     age: int.parse(fieldsList.ageController.text),
  //   );

  //   setState(
  //     () {
  //       widget.employeeList.add(newEmployee);
  //     },
  //   );
  //   return employeeList;
  // }
}
