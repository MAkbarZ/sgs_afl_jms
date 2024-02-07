import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/get_snackbar.dart';

class AFLFunctionController extends GetxController {
  static AFLFunctionController get instance => Get.find();

  final _dbCollection = FirebaseFirestore.instance.collection('afl_function');

  // INPUT TEXT CONTROLLERS

  TextEditingController functionController = TextEditingController();
  bool functionActive = true;

  Future<void> create() async {
    // print(divisionController.text.trim());
    // print(divisionActive);
    await _dbCollection.doc(functionController.text.trim()).set({
      "functionName": functionController.text.trim(),
      "active": functionActive,
    }).catchError((err) {
      SGSSnackbar.getSnackbarRed('Error', 'Following error occorued: \n $err');
    });
  }

  Stream<QuerySnapshot<Object?>> getTwentyRecords(String searchFunction) {
    return _dbCollection
        .orderBy('functionName', descending: false)
        .startAt([searchFunction])
        .endAt(["$searchFunction\uf8ff"])
        .limit(20)
        .snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getActiveAFLFunctions() async {
    return await _dbCollection
        .where('active', isEqualTo: true)
        .get()
        .catchError((err) {
      SGSSnackbar.getSnackbarRed('Error', 'Following error occorued: \n $err');
    });
  }

  Future<void> updateRecord(String functionName, bool active) {
    return _dbCollection.doc(functionName).update({
      "functionName": functionName,
      "active": active,
    });
  }

//
}
