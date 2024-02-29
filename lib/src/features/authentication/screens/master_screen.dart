import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common_widgets/search_textbox.dart';
import '../../../utils/get_snackbar.dart';

import '../controllers/controller_user_admin.dart';
import '../controllers/controller_signup.dart';

import 'login_screen.dart';
import 'user_admin_add_drawer.dart';

class MasterScreen extends StatefulWidget {
  const MasterScreen({super.key});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  final UserAdminController _controller = Get.put(UserAdminController());
  final SignUpController _signUpcontroller = Get.put(SignUpController());

  var _search = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    // String uid = _controller.currentUser?.uid ?? "";
    return SizedBox(
      width: 320,
      child: Scaffold(
        appBar: AppBar(
          title: SearchTextBoxWidget(onChanged: (textValue) {
            setState(() => _search = textValue);
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.to(() => const UserAdminAddScreen()),
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            const Text(
              "Master",
              style: TextStyle(fontSize: 15.0),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: _controller.searchRecords(_search),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      SGSSnackbar.getSnackbarRed(
                          'Error', 'Data could not be retrieved');
                      return Container();
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                                  currentRecord['empId'],
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
                                          _controller.updateRecord(
                                              currentRecord['empId'],
                                              currentRecord['approverEmpId'],
                                              currentValue);
                                        }),
                                  ),
                                ),
                              ]),
                        );
                      }),
                    );
                  }),
            ),
            ElevatedButton(
              onPressed: () {
                _signUpcontroller.logout();
              },
              child: Text('Logout'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => const LoginScreen());
              },
              child: Text('LogIn'),
            ),
          ],
        ),
      ),
    );
  }

//
}
