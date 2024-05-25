import 'package:flutter/material.dart';

import '../models/employee.dart';
import '../widgets/form_widget.dart';

class FormCard extends StatelessWidget {
  final List<Employee> employeeList;
  final String title;

  const FormCard({super.key, required this.title, required this.employeeList});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          SizedBox(
            height: 350,
            width: 350,
            child: Card(
              elevation: 5,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: FormWidget(
                  title: title,
                  employeeList: employeeList,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
