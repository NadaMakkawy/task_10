// class Employee {
//   final int id;
//   final String name;
//   final String gender;
//   final int age;

//   Employee({
//     required this.id,
//     required this.name,
//     required this.gender,
//     required this.age,
//   });

//   factory Employee.fromJson(Map<String, dynamic> data) {
//     return Employee(
//       id: data['id'],
//       name: data['name'],
//       gender: data['gender'],
//       age: data['age'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'gender': gender,
//       'age': age,
//     };
//   }
// }
