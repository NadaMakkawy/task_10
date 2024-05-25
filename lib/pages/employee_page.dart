import 'package:flutter/material.dart';

import '../widgets/form_card.dart';

class EmployeePage extends StatelessWidget {
  const EmployeePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: const Center(
        child: Text('Employees'),
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
                content: const SizedBox(
                  width: double.maxFinite,
                  height: 350,
                  child: FormCard(),
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
}
