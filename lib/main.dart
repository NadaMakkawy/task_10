import 'package:flutter/material.dart';

import 'pages/employee_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Form',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          surface: Colors.deepOrange,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'DarkerGrotesque',
            fontSize: 20,
          ),
          labelMedium: TextStyle(
            fontFamily: 'DarkerGrotesque',
            fontSize: 18,
          ),
          titleMedium: TextStyle(
            fontFamily: 'Righteous',
            fontSize: 35,
            color: Colors.white,
            shadows: [
              BoxShadow(
                offset: Offset(4, 2),
              )
            ],
          ),
        ),
        useMaterial3: true,
      ),
      home: EmployeePage(
        title: 'Employee List',
        employeeList: [],
      ),
    );
  }
}
