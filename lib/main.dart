import 'package:flutter/material.dart';

import 'database/sql_helper.dart';
import 'pages/employee_list_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  var sqlHelper = SqlHelper();
  sqlHelper.init().then((_) {
    runApp(MyApp(sqlHelper: sqlHelper));
  });
}

class MyApp extends StatelessWidget {
  final SqlHelper sqlHelper;

  const MyApp({super.key, required this.sqlHelper});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Form',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(
        //   seedColor: Colors.deepOrange,
        //   surface: Colors.deepOrange,
        // ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey),
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
      home: EmployeeListPage(sqlHelper: sqlHelper),
    );
  }
}
