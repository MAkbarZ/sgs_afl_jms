import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common_widgets/search_textbox.dart';
import '../../../../utils/get_snackbar.dart';
import '../controllers/afl_function_controller.dart';
import 'afl_function_add_drawer.dart';

// import 'package:convert/convert.dart';
// import 'dart:convert';
// import 'package:crypto/crypto.dart';

class AFLFunctionScreen extends StatefulWidget {
  const AFLFunctionScreen({super.key});

  @override
  State<AFLFunctionScreen> createState() => _AFLFunctionScreenState();

  // end of AFLFunctionScreen
}

class _AFLFunctionScreenState extends State<AFLFunctionScreen> {
  final AFLFunctionController _controller = Get.put(AFLFunctionController());

  var searchFunction = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: 320,
      child: Scaffold(
        appBar: AppBar(
          title: SearchTextBoxWidget(onChanged: (textValue) {
            setState(() => searchFunction = textValue);
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.to(() => const AFLFunctionAdd()),
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            const Text(
              "AFL FUNCTION",
              style: TextStyle(fontSize: 15.0),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  // stream: _collection
                  //     .orderBy('functionName', descending: false)
                  //     .startAt([searchFunction])
                  //     .endAt(["$searchFunction\uf8ff"])
                  //     .limit(20)
                  //     .snapshots(),
                  stream: _controller.getTwentyRecords(searchFunction),
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

                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: ((context, index) {
                          var currentRecord = records[index];
                          return Container(
                            margin: const EdgeInsets.only(
                                top: 10, left: 10, right: 10),
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
                                  // ),

                                  Text(
                                    currentRecord['functionName'],
                                    style: const TextStyle(fontSize: 12.0),
                                  ),
                                  const Spacer(),
                                  Text(
                                    currentRecord['active']
                                        ? "active"
                                        : "Inactive",
                                    style: currentRecord['active']
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
                                          value: currentRecord['active'],
                                          onChanged: (bool currentValue) {
                                            // setState(() =>
                                            // _collection
                                            //     .doc(currentRecord[
                                            //         'functionName'])
                                            //     .update({
                                            //   "functionName":
                                            //       currentRecord['functionName'],
                                            //   "active": currentValue,
                                            // });
                                            _controller.updateRecord(
                                                currentRecord['functionName'],
                                                currentValue);
                                            // );
                                          }),
                                    ),
                                  ),

                                  //EDIT BUTTON - NOT REQUIRED TILL NOW.
                                  // const SizedBox(width: 20.0),
                                  // IconButton(
                                  //     onPressed: () {
                                  //       // scaffoldKey.currentState!.openEndDrawer();
                                  //       //     if(scaffoldKey.currentState.isDrawerOpen){
                                  //       //   scaffoldKey.currentState.openEndDrawer();
                                  //       // }else{
                                  //       //   scaffoldKey.currentState.openDrawer();
                                  //       // }
                                  //       Get.to(() => const AFLDivisionAdd(),
                                  //           transition: Transition.rightToLeft);
                                  //     },
                                  //     icon: const Icon(
                                  //       Icons.edit,
                                  //       size: 20.0,
                                  //     ))
                                  //

                                  // //  DELETE BUTTON
                                  // const SizedBox(width: 20.0),
                                  // IconButton(
                                  //     onPressed: () {
                                  //       // scaffoldKey.currentState!.openEndDrawer();
                                  //       //     if(scaffoldKey.currentState.isDrawerOpen){
                                  //       //   scaffoldKey.currentState.openEndDrawer();
                                  //       // }else{
                                  //       //   scaffoldKey.currentState.openDrawer();
                                  //       // }
                                  //       Get.to(() => const AFLDivisionAdd(),
                                  //           transition: Transition.rightToLeft);
                                  //     },
                                  //     icon: const Icon(
                                  //       Icons.delete,
                                  //       size: 20.0,
                                  //       color: Colors.red,
                                  //     ))
                                ]),
                          );
                        }));
                  }),
            ),
          ],
        ),
      ),
    );
    // end of "Widget build"
  }

// ********** WIDGETS AS VARIABLES **********

  // end of "_AFLFunctionScreenState" class
}
