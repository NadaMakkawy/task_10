import 'package:flutter/material.dart';

class EmployeeDataTable extends StatelessWidget {
  final List<Map<String, dynamic>> employees;
  final bool sortAscending;
  final int sortColumnIndex;
  final Function(int, bool) onSort;
  final Function(BuildContext, Map<String, dynamic>) editEmployee;
  final Function(int) deleteEmployee;

  const EmployeeDataTable({
    super.key,
    required this.employees,
    required this.sortAscending,
    required this.sortColumnIndex,
    required this.onSort,
    required this.editEmployee,
    required this.deleteEmployee,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowColor:
          WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
      border: TableBorder.all(color: Colors.grey),
      headingTextStyle: const TextStyle(color: Colors.white),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      columnSpacing: 20,
      sortAscending: sortAscending,
      sortColumnIndex: sortColumnIndex,
      columns: [
        const DataColumn(label: Text('ID')),
        const DataColumn(label: Text('Name')),
        const DataColumn(label: Text('Gender')),
        DataColumn(
          label: const Text('Age'),
          onSort: onSort,
        ),
        const DataColumn(label: Text('Action')),
      ],
      rows: employees.map((employee) {
        return DataRow(cells: [
          DataCell(Text(employee['id'].toString())),
          DataCell(Text(employee['name'])),
          DataCell(Text(employee['gender'])),
          DataCell(Text(employee['age'].toString())),
          DataCell(
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    editEmployee(context, employee);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete Employee?'),
                          content: Text(
                              'Are you sure you want to delete "${employee['name']}"?'),
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
                                deleteEmployee(employee['id']);
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ]);
      }).toList(),
    );
  }
}
