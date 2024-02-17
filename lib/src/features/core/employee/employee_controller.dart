import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../backend/authentication/authentication_backend.dart';
import '../../../enums/enums.dart';
import '../../../utils/get_snackbar.dart';

import '../../authentication/controllers/staff_authority_controller.dart';
import '../../authentication/controllers/user_controller.dart';
import '../../core/incharge/controllers/afl_division_controller.dart';
import '../../core/incharge/controllers/afl_function_controller.dart';

class EmployeeController extends GetxController {
  static EmployeeController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationBackEnd());
  final _dbCollection = FirebaseFirestore.instance.collection('employee');

  final _aflDivController = Get.put(AFLDivisionController());
  final _aflFunctionController = Get.put(AFLFunctionController());
  final _staffAuthorityController = Get.put(StaffAuthorityController());
  final _userController = Get.put(UserController());

  // StaffModel? _staff;

  // INPUT TEXT CONTROLLERS

  // TextEditingController empIdController = TextEditingController();
  // TextEditingController fullNameController = TextEditingController();
  // TextEditingController hiredDateController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController mobileController = TextEditingController();
  // TextEditingController genderController = TextEditingController();
  // TextEditingController phoneController = TextEditingController();
  // TextEditingController activeController = TextEditingController();
  // TextEditingController approverEmpIdController = TextEditingController();

  // bool employeeActive = false;

  // staff
  String m_empId = '';
  String m_fullName = '';
  String m_hiredDate = '';
  String m_email = '';
  String m_mobile = '';
  String m_phone = '';
  String m_gender = 'male';

  // staff authority
  String m_afl_division = '';
  String m_afl_function = '';

  bool isEmptyEmpID = true;
  bool empIDOK = false;
  bool isEmptyFullName = true;
  bool fullNameOK = false;
  bool isEmptyPhoneNo = true;
  bool phoneNoOK = false;
  bool isEmptyMobileNo = true;
  bool mobileNoOK = false;
  // bool _IsEmptyEmail = true;
  // bool _EmailOK = false;
  bool isEmptyHireDate = true;
  // bool _HireDateOK = false;

  String selectedDate = 'e.g ${DateFormat.yMMMd().format(DateTime.now())}';

  Set<SGSEnumGender> enumGender = <SGSEnumGender>{
    SGSEnumGender.male,
    // SGSEnumGender.female
  };

  String m_selectedDivison = "Enter your AFL Division";
  bool isSelectedDivison = false;

  String m_selectedFunction = "Enter your AFL Function";
  bool isSelectedFunction = false;

  Future<void> create(Map<String, dynamic> data) async {
    await _dbCollection.doc(data['empId']).set(data).catchError((err) {
      SGSSnackbar.getSnackbarRed(
          'Error creating an Employee', 'Following error occorued: \n $err');
    });
  }

  // NEED TO UPDATE USER AS WELL

  // MANAGE AUTHORITY AS WELL

  Stream<QuerySnapshot<Object?>> searchRecords(String search) {
    return _dbCollection
        .orderBy('fullName', descending: false)
        .startAt([search]).endAt(["$search\uf8ff"])
        // .limit(20)
        .snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getEmployeeByID(
      String empId) async {
    return await _dbCollection
        .where('empId', isEqualTo: empId)
        .get()
        // ignore: body_might_complete_normally_catch_error
        .catchError((err) {
      SGSSnackbar.getSnackbarRed(
          'Error getting an Employee', 'Following error occorued: \n $err');
    });
  }

  // Future<QuerySnapshot<Map<String, dynamic>>> getActiveEmployees() async {
  //   return await _dbCollection
  //       .where('active', isEqualTo: true)
  //       .get()
  //       .catchError((err) {
  //     SGSSnackbar.getSnackbarRed('Error getting Employees', 'Following error occorued: \n $err');
  //   });
  // }

  Future<void> updateRecord(Map<String, dynamic> data) {
    return _dbCollection.doc(data['empId']).update({
      // "divisionName": divisionName,
      // "active": active,
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getActiveAFLDivisions() async {
    return await _aflDivController.getActiveAFLDivisions();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getActiveAFLFunctions() async {
    return await _aflFunctionController.getActiveAFLFunctions();
  }

  Future<void> updateUser(Map<String, dynamic> dataUser) async {
    await _userController.updateUser(dataUser);
  }

  Future<void> createAuthority(Map<String, dynamic> dataAuthority) async {
    await _staffAuthorityController.create(dataAuthority);
  }

  User? getCurrentUser() {
    return _authRepo.currentUser;
  }

  bool isInputDataOK() {
    if (isEmptyEmpID == false &&
        empIDOK == true &&
        isEmptyFullName == false &&
        fullNameOK == true &&
        isEmptyPhoneNo == false &&
        phoneNoOK == true &&
        isEmptyMobileNo == false &&
        mobileNoOK == true &&
        // isEmptyEmail == false &&
        // _EmailOK == true &&
        isEmptyHireDate == false &&
        //  _HireDateOK == true &&
        isSelectedDivison == true &&
        isSelectedFunction == true) {
      return true;
    } else {
      return false;
    }
  }

  onSubmit() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    // if (_signUpController
    //     .validateBeforeContinue()) {
    //   _signUpController
    //       .registerAndCreateUser();
    // } else {
    //   // print('input is wrongly entered.');
    //   return;
    // }
    // return null;

    Map<String, dynamic> dataStaff = {};
    Map<String, dynamic> dataUser = {};
    Map<String, dynamic> dataAuthority = {};
    if (isInputDataOK()) {
      print('OK');
      dataStaff = {
        "empId": m_empId,
        "fullName": m_fullName,
        "hiredDate": m_hiredDate,
        "email": m_email,
        "mobile": m_mobile,
        "phone": m_phone,
        "gender": m_gender,
        "approverEmpId": 'TBD',
        "uid": getCurrentUser()?.uid ?? "",
        "active": false,
      };

      dataUser = {
        "empId": m_empId,
        "isVerified": getCurrentUser()?.emailVerified,
        "approverEmpId": 'TBD',
        "uid": getCurrentUser()?.uid ?? "",
        "active": false,
      };
      dataAuthority = {
        "empId": m_empId,
        "fullName": m_selectedDivison,
        "aflDivision": m_selectedDivison,
        "aflFunction": m_selectedFunction,
        "approverEmpId": 'TBD',
        "uid": getCurrentUser()?.uid ?? "",
        "active": false,
      };

      print('Staff');
      print(dataStaff);
      print(dataUser);
      print(dataAuthority);

      create(dataStaff);
      updateUser(dataUser);
      createAuthority(dataAuthority);
    } else {
      print('Input is wrong');
    }
  }

//
}
