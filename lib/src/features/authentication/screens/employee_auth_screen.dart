import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../common_widgets/search_textbox.dart';
import '../../../utils/get_snackbar.dart';
import '../controllers/controller_employee_auth.dart';
import '../models/model_emp_auth.dart';
import 'employee_auth_add_drawer.dart';

// import 'package:convert/convert.dart';
// import 'dart:convert';
// import 'package:crypto/crypto.dart';

class EmployeeAuthScreen extends StatefulWidget {
  const EmployeeAuthScreen({super.key});

  @override
  State<EmployeeAuthScreen> createState() => _EmployeeAuthScreenState();

  // end of EmployeeAuthScreen
}

class _EmployeeAuthScreenState extends State<EmployeeAuthScreen> {
  // final _collection = FirebaseFirestore.instance.collection('afl_division');
  final EmployeeAuthorityController _controller =
      Get.put(EmployeeAuthorityController());

  var search = "";

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: 320,
      child: Scaffold(
        appBar: AppBar(
          title: SearchTextBoxWidget(onChanged: (textValue) {
            setState(() => search = textValue);
          }),
        ),
        floatingActionButton: screenWidth <= 500
            ? FloatingActionButton(
                onPressed: () => Get.to(() => const EmployeeAuthorityAdd()),
                child: const Icon(Icons.add),
              )
            : Container(),
        body: Container(
          width: 400,
          child: Column(
            children: [
              const Text(
                "EMPLOYEE AUTHORITY",
                style: TextStyle(fontSize: 15.0),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot<EmployeeAuthorityModel>>(
                    // stream: _controller.dbCollection
                    //     .orderBy('divisionName', descending: false)
                    //     .startAt([search])
                    //     .endAt(["$search\uf8ff"])
                    //     .limit(20)
                    //     .snapshots(),
                    stream: _controller.getTwentyRecords(search),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        SGSSnackbar.getSnackbarRed(
                            'Error', 'Data could not be retrieved');
                        return Container();
                        // return const Text('Error occurred, while getting data');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // return const Text("Loading");
                        return const Center(child: CircularProgressIndicator());
                      }

                      var records = snapshot.data!.docs;

                      // return GroupedListView<dynamic, String>(
                      return GroupedListView<dynamic, String>(
                        elements: records,
                        groupBy: (element) => element['empId'],
                        groupComparator: (value1, value2) =>
                            value2.compareTo(value1),
                        itemComparator: (item1, item2) => item1['aflDivision']
                            .compareTo(item2['aflDivision']),
                        order: GroupedListOrder.ASC,
                        useStickyGroupSeparators: true,
                        groupSeparatorBuilder: (String value) => Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            value,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),

                        itemBuilder: (c, element) {
                          return Container(
                            margin: const EdgeInsets.only(
                                top: 5, left: 10, right: 10),
                            height: 35.0,
                            padding: const EdgeInsets.only(
                                top: 0.0, left: 10.0, right: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 3.0,
                                      blurStyle: BlurStyle.normal,
                                      spreadRadius: 0.5,
                                      offset: const Offset(2.0, 2.0))
                                ]),
                            child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // leading: CircleAvatar(
                                  //   radius: 24,
                                  //   backgroundImage: NetworkImage(currentRecord['profileImageUrl']),
                                  // )
                                  Text(
                                    element['sortNo'].toString(),
                                    style: const TextStyle(fontSize: 09.0),
                                  ),

                                  // const SizedBox(width: 20.0),
                                  // Text(
                                  //   element['empId'],
                                  //   style: const TextStyle(fontSize: 12.0),
                                  // ),

                                  const SizedBox(width: 20.0),
                                  Text(
                                    element['aflDivision'],
                                    style: const TextStyle(fontSize: 12.0),
                                  ),

                                  const SizedBox(width: 20.0),
                                  Text(
                                    element['aflFunction'],
                                    style: const TextStyle(fontSize: 12.0),
                                  ),

                                  const Spacer(),
                                  Text(
                                    element['active'] ? "active" : "Inactive",
                                    style: element['active']
                                        ? const TextStyle(fontSize: 12.0)
                                        : const TextStyle(
                                            fontSize: 12.0, color: Colors.red),
                                  ),

                                  const SizedBox(width: 15.0),

                                  //SWITCH BUTTON
                                  SizedBox(
                                    // width: 20,
                                    height: 20,
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: Switch(
                                          value: element['active'],
                                          onChanged: (bool currentValue) {
                                            // print(element['active']);
                                            // _controller.updateAuthority(
                                            //     currentRecord['divisionName'],
                                            //     currentValue);
                                          }),
                                    ),
                                  ),

                                  // EDIT BUTTON - NOT REQUIRED TILL NOW.
                                  const SizedBox(width: 20.0),
                                  IconButton(
                                    onPressed: () {
                                      // Get.to(() => const AFLDivisionAdd(),
                                      //     transition: Transition.rightToLeft);
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 20.0,
                                    ),
                                  ),
                                ]),
                          );
                        },

                        //
                      );

                      //
                    }),
              ),
            ],
          ),
        ),
      ),
    );
    // end of "Widget build"
  }

// ********** WIDGETS AS VARIABLES **********

  // end of "_EmployeeAuthScreenState" class

  //
}
