// ignore_for_file: body_might_complete_normally_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../utils/get_snackbar.dart';

class UserAdminController extends GetxController {
  static UserAdminController get instance => Get.find();

  final _dbCollection = FirebaseFirestore.instance.collection('user_admin');
  User? currentUser = FirebaseAuth.instance.currentUser;

  Future<void> create(Map<String, dynamic> data) async {
    var _userId = currentUser?.uid;

    await _dbCollection
        .doc(data['empId'])
        // .doc(_userId)
        .set(
          data,
        )
        .catchError((err) {
      SGSSnackbar.getSnackbarRed('Error', 'Following error occorued: \n $err');
    });
  }

  Stream<QuerySnapshot<Object?>> searchRecords(String search) {
    var _stream = _dbCollection
        .orderBy('empId', descending: false)
        .startAt([search]).endAt(["${search}\uf8ff"])
        // .limit(20)
        .snapshots();
    int x = 0;
    _stream.forEach((element) {
      print(element.docs[x]['empId']);
      x += x;
      // print(element.docs[3]['empId']);
    });
    return _stream;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getActiveAdmins() async {
    return await _dbCollection
        .where('active', isEqualTo: true)
        .get()
        .catchError((err) {
      SGSSnackbar.getSnackbarRed('Error', 'Following error occorued: \n $err');
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAdminsByEmpId(
      String employeeID) async {
    return await _dbCollection
        .where('empId', isEqualTo: employeeID.trim())
        .get()
        .catchError((err) {
      SGSSnackbar.getSnackbarRed('Error', 'Following error occorued: \n $err');
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAdminsByEmail(
      String email) async {
    return await _dbCollection
        .where('email', isEqualTo: email.trim())
        .get()
        .catchError((err) {
      SGSSnackbar.getSnackbarRed('Error', 'Following error occorued: \n $err');
    });
  }

  Future<void> updateRecord(
      String employeeID, String approverEmpId, bool active) {
    return _dbCollection.doc(employeeID.trim()).update({
      "empId": employeeID,
      "approverEmpId": approverEmpId,
      "active": active,
    });
  }

//
}
