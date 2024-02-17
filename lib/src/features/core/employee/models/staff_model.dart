import 'package:cloud_firestore/cloud_firestore.dart';

class StaffModel {
  final String empId;
  final String fullName;
  final int hiredDate;
  final String email;
  final String mobile;
  final String phone;
  final String gender;
  final String approverEmpId;
  final bool active;

  StaffModel({
    required this.empId,
    required this.fullName,
    required this.hiredDate,
    required this.email,
    required this.mobile,
    required this.phone,
    required this.gender,
    required this.approverEmpId,
    required this.active,
  });

  toJason() {
    return {
      "empId": empId,
      "fullName": fullName,
      "hiredDate": hiredDate,
      "email": email,
      "mobile": mobile,
      "phone": phone,
      "gender": gender,
      "approverEmpId": approverEmpId,
      "active": active,
    };
  }

  factory StaffModel.fromDocSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final docData = documentSnapshot.data()!;

    return StaffModel(
      // empId: documentSnapshot.id,
      empId: docData['empId'],
      fullName: docData['fullName'],
      hiredDate: docData['hiredDate'],
      email: docData['email'],
      mobile: docData['mobile'],
      phone: docData['phone'],
      gender: docData['gender'],
      approverEmpId: docData['approverEmpId'],
      active: docData['active'],
    );
  }
}
