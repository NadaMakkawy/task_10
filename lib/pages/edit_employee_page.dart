import 'package:flutter/material.dart';

import '../database/sql_helper.dart';

class EditEmployeePage extends StatefulWidget {
  final Map<String, dynamic> employee;
  final SqlHelper sqlHelper;

  const EditEmployeePage(
      {super.key, required this.employee, required this.sqlHelper});

  @override
  _EditEmployeePageState createState() => _EditEmployeePageState();
}

class _EditEmployeePageState extends State<EditEmployeePage> {
  late TextEditingController _nameController;
  late TextEditingController _genderController;
  late TextEditingController _ageController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.employee['name']);
    _genderController = TextEditingController(text: widget.employee['gender']);
    _ageController =
        TextEditingController(text: widget.employee['age'].toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _genderController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Edit Employee',
          style:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 26),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            // TextFormField(
            //   controller: _genderController,
            //   decoration: const InputDecoration(labelText: 'Gender'),
            // ),
            FormField<String>(
              builder: (FormFieldState<String> state) {
                return DropdownButtonFormField<String>(
                  value: _genderController.text,
                  onChanged: (newValue) {
                    setState(() {
                      _genderController.text = newValue!;
                    });
                  },
                  items: ['Male', 'Female']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                  ),
                );
              },
            ),
            TextFormField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _updateEmployee();
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateEmployee() async {
    try {
      final name = _nameController.text;
      final gender = _genderController.text;
      final age = int.parse(_ageController.text);

      await widget.sqlHelper
          .updateEmployee(widget.employee['id'], name, gender, age);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Employee updated successfully'),
        ));
      }
      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      print('Error updating employee: $e');
    }
  }
}
