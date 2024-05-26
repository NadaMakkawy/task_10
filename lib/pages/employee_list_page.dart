import 'package:flutter/material.dart';

import '../database/sql_helper.dart';
import '../widgets/add_employee_button.dart';
import '../widgets/add_employee_dialog.dart';
import '../widgets/employee_data_table.dart';
import 'edit_employee_page.dart';

class EmployeeListPage extends StatefulWidget {
  final SqlHelper sqlHelper;

  const EmployeeListPage({super.key, required this.sqlHelper});

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _genderController;
  late TextEditingController _ageController;

  bool _sortAscending = true;
  int _sortColumnIndex = 3;

  bool _hasEmployees = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    // _genderController = TextEditingController();
    _ageController = TextEditingController();
    _genderController = TextEditingController(text: 'Male');
    _checkForEmployees();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _genderController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _checkForEmployees() async {
    final employees = await widget.sqlHelper.getEmployees();
    _hasEmployees = employees.isNotEmpty;
    setState(() {});
  }

  Future<void> _addEmployee() async {
    try {
      final name = _nameController.text;
      final gender = _genderController.text;
      final age = int.parse(_ageController.text);

      await widget.sqlHelper.insertEmployee(name, gender, age);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Employee added successfully'),
        ));
      }

      _nameController.clear();
      // _genderController.clear();
      _ageController.clear();

      if (mounted) {
        Navigator.of(context).pop();
      }
      setState(() {});
    } catch (e) {
      print('Error adding employee: $e');
    }
  }

  Future<void> _editEmployee(
      BuildContext context, Map<String, dynamic> employee) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditEmployeePage(employee: employee, sqlHelper: widget.sqlHelper),
      ),
    );
    if (result != null && result) {
      setState(() {});
    }
  }

  Future<void> _deleteEmployee(int id) async {
    try {
      await widget.sqlHelper.deleteEmployee(id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Employee deleted successfully'),
        ));
      }
      setState(() {});
    } catch (e) {
      print('Error deleting employee: $e');
    }
  }

  Future<void> _deleteAllEmployees() async {
    try {
      await widget.sqlHelper.deleteAllEmployees();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('All employees deleted successfully.'),
        ));
      }
      setState(() {});
    } catch (e) {
      print('Error deleting all employees: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Employee List',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: widget.sqlHelper.getEmployees(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<Map<String, dynamic>> employees =
                      List.from(snapshot.data!);
                  if (_sortAscending) {
                    employees.sort((a, b) => a['age'].compareTo(b['age']));
                  } else {
                    employees.sort((a, b) => b['age'].compareTo(a['age']));
                  }
                  return employees.isNotEmpty
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                              child: EmployeeDataTable(
                            employees: employees,
                            sortAscending: _sortAscending,
                            sortColumnIndex: _sortColumnIndex,
                            onSort: (columnIndex, ascending) {
                              setState(() {
                                _sortColumnIndex = columnIndex;
                                _sortAscending = ascending;
                              });
                            },
                            editEmployee: (context, employee) {
                              _editEmployee(context, employee);
                            },
                            deleteEmployee: (id) {
                              _deleteEmployee(id);
                              _checkForEmployees();
                            },
                          )),
                        )
                      : Center(
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AddEmployeeDialog(
                                    formKey: _formKey,
                                    nameController: _nameController,
                                    genderController: _genderController,
                                    ageController: _ageController,
                                    onPressedFn: () {
                                      if (_formKey.currentState!.validate()) {
                                        _addEmployee();
                                        _checkForEmployees();
                                      }
                                    },
                                  );
                                },
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('No Data'),
                                const Divider(
                                  indent: 100,
                                  endIndent: 100,
                                ),
                                const Text('Add some Employees!'),
                                const Icon(
                                  Icons.arrow_drop_down_rounded,
                                  size: 40,
                                  color: Colors.white,
                                ),
                                // FloatingActionButton(
                                //   onPressed: () {
                                //     showDialog(
                                //       context: context,
                                //       builder: (context) {
                                //         return AddEmployeeDialog(
                                //           formKey: _formKey,
                                //           nameController: _nameController,
                                //           genderController: _genderController,
                                //           ageController: _ageController,
                                //           onPressedFn: () {
                                //             if (_formKey.currentState!
                                //                 .validate()) {
                                //               _addEmployee();
                                //               _checkForEmployees();
                                //             }
                                //           },
                                //         );
                                //       },
                                //     );
                                //   },
                                //   tooltip: 'Add Employee',
                                //   child: const Icon(Icons.add),
                                // ),
                                AddEmployeeButton(
                                  formKey: _formKey,
                                  nameController: _nameController,
                                  genderController: _genderController,
                                  ageController: _ageController,
                                  onPressedFn: () {
                                    if (_formKey.currentState!.validate()) {
                                      _addEmployee();
                                      _checkForEmployees();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: _hasEmployees
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Delete All Employees?'),
                                content: const Text(
                                    'Are you sure you want to delete all employees?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      _deleteAllEmployees();
                                      _checkForEmployees();
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text('Delete All Employees'),
                      ),
                      AddEmployeeButton(
                        formKey: _formKey,
                        nameController: _nameController,
                        genderController: _genderController,
                        ageController: _ageController,
                        onPressedFn: () {
                          if (_formKey.currentState!.validate()) {
                            _addEmployee();
                            _checkForEmployees();
                          }
                        },
                      ),
                    ],
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
