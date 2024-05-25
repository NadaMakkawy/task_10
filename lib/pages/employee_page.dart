import 'package:flutter/material.dart';

import '../models/employee.dart';
import '../widgets/employee_card.dart';
import '../widgets/form_card.dart';

class EmployeePage extends StatefulWidget {
  final List<Employee> employeeList;
  final String title;

  const EmployeePage(
      {super.key, required this.title, required this.employeeList});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body:
          //  const Center(
          //   child: Text('Employees'),
          // ),
          widget.employeeList.isEmpty
              ? const Center(
                  child: Text('No Data'),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      //  ListView(
                      //   children: getEmployeeCards(),
                      // ),
                      ListView.builder(
                    itemCount: widget.employeeList.length,
                    itemBuilder: (context, index) {
                      return EmployeeCard(employee: widget.employeeList[index]);
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Theme.of(context).colorScheme.primary,
                title: Center(
                  child: Text(
                    'Add Employee',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 28,
                        ),
                  ),
                ),
                content: SizedBox(
                  width: double.maxFinite,
                  height: 350,
                  child: FormCard(
                    employeeList: widget.employeeList,
                    title: widget.title,
                  ),
                  // child: FormWidget(
                  //   employeeList: widget.employeeList,
                  //   title: widget.title,
                  // ),
                ),
              );
            },
          );
        },
        tooltip: 'Add Employee',
        child: const Icon(Icons.add),
      ),
    );
  }

  // List<Widget> getEmployeeCards() {
  //   List<Widget> employeeCards = [];

  //   for (var emp in widget.employeeList) {
  //     employeeCards.add(EmployeeCard(employee: emp));
  //   }

  //   return employeeCards;
  // }
}
