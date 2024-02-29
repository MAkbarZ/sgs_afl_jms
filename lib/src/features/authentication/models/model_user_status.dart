import 'package:cloud_firestore/cloud_firestore.dart';

class UserStatusModel {
  final String empId;
  final bool staffIsApproved;
  final bool staffIsActive;
  final String email;
  final bool emailIsVerified;
  final bool userIsActive;
  final String currentDbRole;
  final List<String>? divisions;
  final List<String>? functions;

  UserStatusModel({
    required this.empId,
    required this.staffIsApproved,
    required this.staffIsActive,
    required this.email,
    required this.emailIsVerified,
    required this.userIsActive,
    required this.currentDbRole,
    required this.divisions,
    required this.functions,
  });

  toJason() {
    return {
      "emp_id": empId,
      "staff_is_approved": staffIsApproved,
      "staff_is_active": staffIsActive,
      "email": email,
      "email_is_verified": emailIsVerified,
      "user_is_active": userIsActive,
      "current_db_role": currentDbRole,
      "list_active_division": divisions,
      "list_active_functions": functions,
    };
  }

  factory UserStatusModel.fromDocSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final docData = documentSnapshot.data()!;

    // print(documentSnapshot.id);
    // OUTPUT =  1IOt5qWS82XvmMI4PEZU
    // print(docData);
    // OUTPUT = {email: e5mail@email.com, fullName: f5ull name, phone: +92 123 456 7895, password: p5assword}
    return UserStatusModel(
      empId: documentSnapshot.id,
      staffIsApproved: docData['staff_is_approved'],
      staffIsActive: docData['staff_is_active'],
      email: docData['email'],
      emailIsVerified: docData['email_is_verified'],
      userIsActive: docData['user_is_active'],
      currentDbRole: docData['current_db_role'],
      divisions: docData['list_active_division'] is Iterable
          ? List.from(docData['list_active_division'])
          : null,
      functions: docData['list_active_functions'] is Iterable
          ? List.from(docData['list_active_functions'])
          : null,
    );
  }
}
