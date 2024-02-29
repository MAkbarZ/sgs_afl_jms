import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeAuthorityModel {
  int _sortNo;
  String _empId;
  // final String uid;
  String _aflDivision;
  String _aflFunction;
  String _approverEmpId;
  String _dbRole;
  bool _active;

  EmployeeAuthorityModel(
      {required int sortNo,
      required String empId,
      // required this._uid,
      required String aflDivision,
      required String aflFunction,
      required String approverEmpId,
      required String dbRole,
      required bool active})
      : _sortNo = sortNo,
        _empId = empId,
        _aflDivision = aflDivision,
        _aflFunction = aflFunction,
        _approverEmpId = approverEmpId,
        _dbRole = dbRole,
        _active = active;

  // GETTERS
  int get sortNo => _sortNo;
  String get empId => _empId;
  String get aflDivision => _aflDivision;
  String get aflFunction => _aflFunction;
  String get approverEmpId => _approverEmpId;
  String get dbRole => _dbRole;
  bool get active => _active;

  // SETTERS
  set sortNo(int value) => _sortNo = value;
  set empId(String value) => _empId = value;
  // set uid(String value) => this.uid = value;
  set aflDivision(String value) => _aflDivision = value;
  set aflFunction(String value) => _aflFunction = value;
  set approverEmpId(String value) => _approverEmpId = value;
  set dbRole(String value) => _dbRole = value;
  set active(bool value) => _active = value;

  // FOR FIRESTORE
  factory EmployeeAuthorityModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return EmployeeAuthorityModel(
        sortNo: data?['sortNo'],
        empId: data?['empId'],
        // uid: data?['uid'],
        aflDivision: data?['aflDivision'],
        aflFunction: data?['aflFunction'],
        approverEmpId: data?['approverEmpId'],
        dbRole: data?['dbRole'],
        active: data?['active']);
  }

  // FOR FIRESTORE
  Map<String, dynamic> toFirestore() {
    return {
      // if (empId != null) 'empId': empId,
      'sortNo': sortNo,
      'empId': empId,
      // 'uid': uid,
      'aflDivision': aflDivision,
      'aflFunction': aflFunction,
      'approverEmpId': approverEmpId,
      'dbRole': dbRole,
      'active': active
    };
  }

  // isEmpIdOK(String empId) => Validator().isEmployeeID(empId);
  // isAflDivisionOK(String aflDivision) => aflDivision != '';
  // isAflFunctionOK(String aflFunction) => aflFunction != '';
  // isApproverEmpIdOK(String approverEmpId) =>
  //     Validator().isEmployeeID(approverEmpId);
  // isdbRoleOK(String dbRole) => dbRole != '';
  // isActiveOK() => active;
}
