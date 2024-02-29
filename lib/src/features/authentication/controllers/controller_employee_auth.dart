// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

import '../../../utils/get_snackbar.dart';
import '../../core/incharge/controllers/afl_division_controller.dart';
import '../../core/incharge/controllers/afl_function_controller.dart';
import '../models/model_emp_auth.dart';

class EmployeeAuthorityController extends GetxController {
  static EmployeeAuthorityController get instance => Get.find();

  // final _dbCollection =
  //     FirebaseFirestore.instance.collection('employee_authority');
  final _dbModelRef = FirebaseFirestore.instance
      .collection('employee_authority')
      .withConverter<EmployeeAuthorityModel>(
          fromFirestore: EmployeeAuthorityModel.fromFireStore,
          toFirestore: (EmployeeAuthorityModel model, options) =>
              model.toFirestore());

  final _aflDivController = Get.put(AFLDivisionController());
  final _aflFunctionController = Get.put(AFLFunctionController());

  List<EmployeeAuthorityModel> existingAuths = [];

  var authority = EmployeeAuthorityModel(
      sortNo: 0,
      empId: '',
      aflDivision: '',
      aflFunction: '',
      dbRole: '',
      approverEmpId: '',
      active: true);

  bool isEmptyEmpID = true;
  bool empIDOK = false;

  List<String> divList = [];
  List<String> functionList = [];
  List<String> dbRoleList = ['Both', 'Read', 'Write'];

  String selectedDivison = "Enter your AFL Division";
  String selectedFunction = "Enter your AFL Function";
  String selectedDBRole = "Enter your DB Access Role";

  bool isSelectedFunction = false;
  bool isSelectedDivison = false;
  bool isSelectedDBRole = false;

  // Future<void> create(Map<String, dynamic> data) async {
  Future<void> create(EmployeeAuthorityModel data) async {
    String _newEmpId = '';
    await getExistingAuth(data.empId);

    if (existingAuths.isNotEmpty) {
      _newEmpId = '${data.empId}_${(existingAuths.length) + 1}';
      data.sortNo = (existingAuths.length) + 1;
      // print('new $_newEmpId');
      // for (var obj in existingAuths) {
      //   print('List item ---- ${obj.sortNo} & ${obj.aflDivision}');
      // }
    } else {
      _newEmpId = '${data.empId}_1';
      data.sortNo = 1;
      // print('existing $_newEmpId');
    }

    await _dbModelRef
            .doc(_newEmpId)
            .set(
              data,
            )
            .then(
                (value) => SGSSnackbar.getSnackbarGreen(
                    "Employee's authority created", 'Successfully.'),
                onError: (e) => SGSSnackbar.getSnackbarRed(
                    "Error creating an Employee's Authority",
                    'Following error occorued: \n $e'))
        //     .catchError((err) {
        //   SGSSnackbar.getSnackbarRed('Error', 'Following error occorued: \n $err');
        // })
        ;
  }

  Stream<QuerySnapshot<EmployeeAuthorityModel>> getTwentyRecords(
      String search) {
    return _dbModelRef
        .orderBy('empId', descending: false)
        .startAt([search])
        .endAt(["$search\uf8ff"])
        .limit(20)
        .snapshots();
  }

  // Future<QuerySnapshot<Map<String, dynamic>>> getActiveRecords() async {
  Future<QuerySnapshot<EmployeeAuthorityModel>> getActiveRecords() async {
    return await _dbModelRef
        .where('active', isEqualTo: true)
        .get()
        // .then(
        //     (value) => SGSSnackbar.getSnackbarGreen(
        //         "Employee's authority created", 'Successfully.'),
        //     onError: (e) => SGSSnackbar.getSnackbarRed(
        //         "Error creating an Employee's Authority",
        //         'Following error occorued: \n $e'));
        .catchError((err) {
      SGSSnackbar.getSnackbarRed('Error getting Active Authorities',
          'Following error occorued: \n $err');
    });
  }

  // Future<void> updateAuthority(Map<String, dynamic> data) {
  Future<void> updateAuthority(EmployeeAuthorityModel data) {
    // return _dbCollection.doc(data['empId']).update(data).then(
    return _dbModelRef.doc(data.empId).update(data.toFirestore()).then(
        (value) => SGSSnackbar.getSnackbarGreen(
            "Employee's Authority updated", 'Successfully.'),
        onError: (e) => SGSSnackbar.getSnackbarRed(
            'Error updating this Authority',
            'Following error occorued: \n $e'));
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getActiveAFLDivisions() async {
    return await _aflDivController.getActiveAFLDivisions();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getActiveAFLFunctions() async {
    return await _aflFunctionController.getActiveAFLFunctions();
  }

  getExistingAuth(String empId) async {
    existingAuths.clear();

    await _dbModelRef
        .where('empId', isEqualTo: empId)
        .get()
        .then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        existingAuths.add(docSnapshot.data());

        // print(
        //     '${docSnapshot.id} => ${docSnapshot.data().sortNo.toString()} ${docSnapshot.data().aflDivision}');
      }

      // for (var obj in existingAuths) {
      //   print('List item ---- ${obj.sortNo} & ${obj.aflDivision}');
      // }
    });
  }

  onSubmit() async {
    // SystemChannels.textInput.invokeMethod('TextInput.hide');

    // print(authority.empId);
    // print(authority.aflDivision);
    // print(authority.aflFunction);
    // print(authority.dbRole);
    // print(authority.approverEmpId);
    // print(authority.active);

    create(authority);
  }
//
}
