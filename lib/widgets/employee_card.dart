import 'package:flutter/material.dart';

import '../models/employee.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;
  const EmployeeCard({required this.employee, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text(
          employee.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(employee.gender),
            Text(
              employee.age.toString(),
            ),
          ],
        ),
        // trailing: const Icon(Icons.delete),
      ),
    );
  }
}
