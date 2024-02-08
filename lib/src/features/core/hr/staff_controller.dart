import 'package:afljms/src/features/core/hr/models/staff_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../utils/get_snackbar.dart';

class StaffController extends GetxController {
  static StaffController get instance => Get.find();

  final _dbCollection = FirebaseFirestore.instance.collection('staff');

  StaffModel? _staff;

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

  Future<void> create(Map<String, dynamic> data) async {
    await _dbCollection
        .doc(data['empId'])
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

  // Future<void> updateRecord(String divisionName, bool active) {
  //   return _dbCollection.doc(divisionName).update({
  //     "divisionName": divisionName,
  //     "active": active,
  //   });
  // }

//
}
