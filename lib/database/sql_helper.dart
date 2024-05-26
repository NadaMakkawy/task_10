import 'package:sqflite/sqflite.dart';

// import '../models/employee_model.dart';

class SqlHelper {
  late Database db;

  Future<void> createTables() async {
    try {
      await db.execute('''
CREATE TABLE IF NOT EXISTS employees (
  id INTEGER PRIMARY KEY,
  name TEXT,
  gender TEXT,
  age INTEGER
)
''');
    } catch (e) {
      print('Error in creating table: $e');
    }
  }

  Future<void> init() async {
    try {
      db = await openDatabase('pos.db', version: 1, onCreate: (db, version) {
        print('database created successfully $db');
      });
      await createTables();
    } catch (e) {
      print('Error creating database: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getEmployees() async {
    try {
      return await db.query('employees');
    } catch (e) {
      print('Error getting employees: $e');
      return [];
    }
  }

  // Future<List<Employee>> getEmployees() async {
  //   try {
  //     final List<Map<String, dynamic>> rows = await db.query('employees');
  //     return rows.map((row) => Employee.fromJson(row)).toList();
  //   } catch (e) {
  //     print('Error getting employees: $e');
  //     return [];
  //   }
  // }

  // Future<List<Map<String, dynamic>>> getEmployeesAsMap() async {
  //   List<Employee> employees = await getEmployees();
  //   return employees.map((employee) => employee.toJson()).toList();
  // }

  Future<void> insertEmployee(String name, String gender, int age) async {
    try {
      await db
          .insert('employees', {'name': name, 'gender': gender, 'age': age});
      print('Employee inserted successfully.');
    } catch (e) {
      print('Error inserting employee: $e');
    }
  }

  Future<void> updateEmployee(
      int id, String name, String gender, int age) async {
    try {
      await db.update(
        'employees',
        {'name': name, 'gender': gender, 'age': age},
        where: 'id = ?',
        whereArgs: [id],
      );
      print('Employee updated successfully.');
    } catch (e) {
      print('Error updating employee: $e');
    }
  }

  Future<void> deleteEmployee(int id) async {
    try {
      await db.delete(
        'employees',
        where: 'id = ?',
        whereArgs: [id],
      );
      print('Employee deleted successfully.');
    } catch (e) {
      print('Error deleting employee: $e');
    }
  }

  Future<void> deleteAllEmployees() async {
    try {
      await db.delete('employees');
      print('All employees deleted successfully.');
    } catch (e) {
      print('Error deleting employees: $e');
    }
  }
}
