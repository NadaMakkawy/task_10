import 'package:flutter/material.dart';

class AddEmployeeDialog extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController genderController;
  final TextEditingController ageController;
  final Function() onPressedFn;

  const AddEmployeeDialog({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.genderController,
    required this.ageController,
    required this.onPressedFn,
  });

  @override
  State<AddEmployeeDialog> createState() => _AddEmployeeDialogState();
}

class _AddEmployeeDialogState extends State<AddEmployeeDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Center(
        child: Text(
          'Add Employee',
          style:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 28),
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: 350,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: widget.formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: widget.nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  // TextFormField(
                  //   controller: _genderController,
                  //   decoration: const InputDecoration(
                  //       labelText: 'Gender'),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter a gender';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return DropdownButtonFormField<String>(
                        value: widget.genderController.text,
                        onChanged: (newValue) {
                          setState(() {
                            widget.genderController.text = newValue!;
                          });
                        },
                        items: ['Male', 'Female'].map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            );
                          },
                        ).toList(),
                        decoration: const InputDecoration(
                          labelText: 'Gender',
                        ),
                      );
                    },
                  ),
                  TextFormField(
                    controller: widget.ageController,
                    decoration: const InputDecoration(labelText: 'Age'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an age';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        foregroundColor: Colors.white,
                        elevation: 5,
                      ),
                      onPressed: widget.onPressedFn,
                      child: const Text('Add Employee'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
