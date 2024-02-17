import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../utils/get_snackbar.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final _dbCollection = FirebaseFirestore.instance.collection('users');

  Future<void> create(Map<String, dynamic> data) async {
    await _dbCollection
        .doc(data['email'])
        .set(
          data,
        )
        .catchError((err) {
      SGSSnackbar.getSnackbarRed('Error', 'Following error occorued: \n $err');
    });
  }

  // Stream<QuerySnapshot<Object?>> getTwentyRecords(String searchDivision) {
  //   return _dbCollection
  //       .orderBy('divisionName', descending: false)
  //       .startAt([searchDivision])
  //       .endAt(["$searchDivision\uf8ff"])
  //       .limit(20)
  //       .snapshots();
  // }

  // Future<QuerySnapshot<Map<String, dynamic>>> getActiveAFLDivisions() async {
  //   return await _dbCollection
  //       .where('active', isEqualTo: true)
  //       .get()
  //       .catchError((err) {
  //     SGSSnackbar.getSnackbarRed('Error', 'Following error occorued: \n $err');
  //   });
  // }

  Future<void> updateUser(Map<String, dynamic> data) {
    return _dbCollection.doc(data['uid']).update(data);
  }
  // Future<void> updateRecord(String divisionName, bool active) {
  //   return _dbCollection.doc(divisionName).update({
  //     "divisionName": divisionName,
  //     "active": active,
  //   });
  // }

//
}
