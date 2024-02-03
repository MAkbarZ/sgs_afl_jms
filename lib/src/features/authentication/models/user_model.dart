import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String empId;
  final String password;
  final String dbRole;
  final bool active;

  UserModel({
    required this.empId,
    required this.password,
    required this.dbRole,
    required this.active,
  });

  toJason() {
    return {
      "emp_id": empId,
      "password": password,
      "db_role": dbRole,
      "active": dbRole,
    };
  }

  factory UserModel.fromDocSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final docData = documentSnapshot.data()!;

    // print(documentSnapshot.id);
    // OUTPUT =  1IOt5qWS82XvmMI4PEZU
    // print(docData);
    // OUTPUT = {email: e5mail@email.com, fullName: f5ull name, phone: +92 123 456 7895, password: p5assword}
    return UserModel(
      empId: documentSnapshot.id,
      password: docData['password'],
      dbRole: docData['db_role'],
      active: docData['active'],
    );
  }
}
