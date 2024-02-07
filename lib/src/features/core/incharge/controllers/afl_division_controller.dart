import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/get_snackbar.dart';

class AFLDivisionController extends GetxController {
  static AFLDivisionController get instance => Get.find();

  final _dbCollection = FirebaseFirestore.instance.collection('afl_division');

  // INPUT TEXT CONTROLLERS

  TextEditingController divisionController = TextEditingController();
  bool divisionActive = true;

  Future<void> create() async {
    // print(divisionController.text.trim());
    // print(divisionActive);
    await _dbCollection.doc(divisionController.text.trim()).set({
      "divisionName": divisionController.text.trim(),
      "active": divisionActive,
    }).catchError((err) {
      SGSSnackbar.getSnackbarRed('Error', 'Following error occorued: \n $err');
    });
  }

  Stream<QuerySnapshot<Object?>> getTwentyRecords(String searchDivision) {
    return _dbCollection
        .orderBy('divisionName', descending: false)
        .startAt([searchDivision])
        .endAt(["$searchDivision\uf8ff"])
        .limit(20)
        .snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getActiveAFLDivisions() async {
    return await _dbCollection
        .where('active', isEqualTo: true)
        .get()
        .catchError((err) {
      SGSSnackbar.getSnackbarRed('Error', 'Following error occorued: \n $err');
    });
  }

  Future<void> updateRecord(String divisionName, bool active) {
    return _dbCollection.doc(divisionName).update({
      "divisionName": divisionName,
      "active": active,
    });
  }

//
}
