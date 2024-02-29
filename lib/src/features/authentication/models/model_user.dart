// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String _uid;
  String _empId;
  // String _password;
  String _fullName;
  int _hiredDate;
  String _email;
  String _mobile;
  String _phone;
  String _gender;
  String _approverEmpId;
  bool _active;

  UserModel(
      {required String uid,
      required String empId,
      // required String password,
      required String fullName,
      required int hiredDate,
      required String email,
      required String mobile,
      required String phone,
      required String gender,
      required String approverEmpId,
      required bool active})
      : _uid = uid,
        _empId = empId,
        // _password = password,
        _fullName = fullName,
        _hiredDate = hiredDate,
        _email = email,
        _mobile = mobile,
        _phone = phone,
        _gender = gender,
        _approverEmpId = approverEmpId,
        _active = active;

  // GETTERS
  String get uid => _uid;
  String get empId => _empId;
  // String get password => _password;
  String get fullName => _fullName;
  int get hiredDate => _hiredDate;
  String get email => _email;
  String get mobile => _mobile;
  String get phone => _phone;
  String get gender => _gender;
  String get approverEmpId => _approverEmpId;
  bool get active => _active;

// SETTERS
  set uid(String value) => _uid = value;
  set empId(String value) => _empId = value;
  set fullName(String value) => _fullName = value;
  set hiredDate(int value) => _hiredDate = value;
  set email(String value) => _email = value;
  set mobile(String value) => _mobile = value;
  set phone(String value) => _phone = value;
  set gender(String value) => _gender = value;
  set approverEmpId(String value) => _approverEmpId = value;
  set active(bool value) => _active = value;

// FOR FIRESTORE
  factory UserModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return UserModel(
        uid: data?['uid'],
        empId: data?['empId'],
        // password: data?['password'],
        fullName: data?['fullName'],
        hiredDate: data?['hiredDate'],
        email: data?['email'],
        mobile: data?['mobile'],
        phone: data?['phone'],
        gender: data?['gender'],
        approverEmpId: data?['approverEmpId'],
        active: data?['active']);
  }

  // FOR FIRESTORE
  Map<String, dynamic> toFirestore() {
    return {
      // if (empId != null) 'empId': empId,
      'uid': uid,
      'empId': empId,
      // 'password': password,
      'fullName': fullName,
      'hiredDate': hiredDate,
      'email': email,
      'mobile': mobile,
      'phone': phone,
      'gender': gender,
      'approverEmpId': approverEmpId,
      'active': active
    };
  }
}
