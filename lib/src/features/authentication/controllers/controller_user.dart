import 'dart:async';

import 'package:afljms/src/features/authentication/models/model_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../utils/get_snackbar.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  // final _dbCollection = FirebaseFirestore.instance.collection('users');
  final _dbModelRef = FirebaseFirestore.instance
      .collection('employee_authority')
      .withConverter<UserModel>(
          fromFirestore: UserModel.fromFireStore,
          toFirestore: (UserModel model, options) => model.toFirestore());

  var userObj = UserModel(
      uid: '',
      empId: '',
      // password: '',
      fullName: '',
      hiredDate: 20191216,
      email: '',
      mobile: '',
      phone: '',
      gender: '',
      approverEmpId: '',
      active: true);

  Future<void> create(UserModel data) async {
    await _dbModelRef
            .doc(data.uid)
            .set(
              data,
            )
            .then(
                (value) => SGSSnackbar.getSnackbarGreen(
                    'User created', 'Successfully.'),
                onError: (e) => SGSSnackbar.getSnackbarRed(
                    'Error creating a User account',
                    'Following error occorued: \n $e'))
        //     .catchError((err) {
        //   SGSSnackbar.getSnackbarRed('Error', 'Following error occorued: \n $err');
        // })
        ;
  }

//  Future<QuerySnapshot<Map<String, dynamic>>> getUserQueryByUid(
  Future<QuerySnapshot<UserModel>> getUserQueryByUid(String uid) async {
    return await _dbModelRef
        .where('uid', isEqualTo: uid)
        .get()
        // .then(
        //     (QuerySnapshot<UserModel> querySnapshot) {
        //   // return querySnapshot;
        //   return querySnapshot.docs.first;
        //   // for (var docSnapshot in querySnapshot.docs) {
        //   //   print('${docSnapshot.id} => ${docSnapshot.data()}');
        //   // }
        // },
        //     onError: (e) => SGSSnackbar.getSnackbarRed(
        //         'Error updating the Employee', 'Following error occorued: \n $e'));
        .catchError((err) {
      SGSSnackbar.getSnackbarRed('Error getting Active Authorities',
          'Following error occorued: \n $err');
    });
  }

  Future<bool> checkUserStatus(String uid) async {
    // Timer.periodic(const Duration(seconds: 3), (timer) {
    // Timer.periodic(const Duration(seconds: 3), (timer) {
    var status = await _dbModelRef.doc(uid).get().then((docSnapshot) {
      return docSnapshot.data()!.active;
    },
        onError: (e) => SGSSnackbar.getSnackbarRed(
            'Error checking User Status', 'Following error occorued: \n $e'));
    //   .catchError((err) {
    // SGSSnackbar.getSnackbarRed('Error getting Active Authorities',
    //     'Following error occorued: \n $err');
    // });
    print('status is ${status}');
    return status;
    // });
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

  Future<void> updateUser(UserModel data) {
    return _dbModelRef.doc(data.uid).update(data.toFirestore()).then(
        (value) =>
            SGSSnackbar.getSnackbarGreen('User updated', 'Successfully.'),
        onError: (e) => SGSSnackbar.getSnackbarRed(
            'Error updating the User', 'Following error occorued: \n $e'));
  }

//
}
