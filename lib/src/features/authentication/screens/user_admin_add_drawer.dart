import 'package:afljms/src/features/authentication/screens/user_admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../common_widgets/input_field.dart';
import '../../../utils/text_input_validator.dart';

import '../controllers/user_admin_controller.dart';

class UserAdminAddScreen extends StatefulWidget {
  const UserAdminAddScreen({
    super.key,
  });

  @override
  State<UserAdminAddScreen> createState() => UuseMmanagerAddScreenState();
}

class UuseMmanagerAddScreenState extends State<UserAdminAddScreen> {
  final UserAdminController _controller = Get.put(UserAdminController());

  String m_empId = '';
  String m_approverEmpId = '';

  bool _isEmptyEmpID = true;
  bool _empIDOK = false;
  bool _isEmptyAproverEmpId = true;
  bool _approverEmpIdOK = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      // width: 320,
      child: Scaffold(
        // key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Get.back();
                // Get.to(() => const InchargeDashboard(),
                //     transition: Transition.leftToRight);
              }),
          title: const Text('Add a User Admin'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SGSInputField(
                  title: 'Employee ID',
                  hint: 'e.g. 02075',
                  maxLength: 10,
                  isObscure: false,
                  readonly: false,
                  onChanged: (textValue) {
                    setState(() {
                      if (textValue.trim() != "") {
                        setState(() {
                          _isEmptyEmpID = false;
                          _empIDOK = Validator().isEmployeeID(textValue);

                          if (_isEmptyEmpID == false && _empIDOK == true) {
                            m_empId = textValue;
                          } else {
                            m_empId = "";
                          }
                        });
                      } else {
                        setState(() => _isEmptyEmpID = true);
                        return;
                      }
                    });
                  }),
              _isEmptyEmpID
                  ? Text("Please enter your Employee ID.",
                      style: warningTextStyle)
                  : _empIDOK == false
                      ? Text('Enter 15 numerical digits, only. (e.g. 02075)',
                          style: warningTextStyle)
                      : Container(),

              const SizedBox(height: 20),

              SGSInputField(
                  title: "Approver's Employee ID",
                  hint: 'e.g. 02001',
                  maxLength: 10,
                  isObscure: false,
                  readonly: false,
                  onChanged: (textValue) {
                    setState(() {
                      if (textValue.trim() != "") {
                        setState(() {
                          _isEmptyAproverEmpId = false;
                          _approverEmpIdOK =
                              Validator().isEmployeeID(textValue);

                          if (_isEmptyAproverEmpId == false &&
                              _approverEmpIdOK == true) {
                            m_approverEmpId = textValue;
                          } else {
                            m_approverEmpId = "";
                          }
                        });
                      } else {
                        setState(() => _isEmptyAproverEmpId = true);
                        return;
                      }
                    });
                  }),
              _isEmptyAproverEmpId
                  ? Text("Please enter Approver's Employee ID.",
                      style: warningTextStyle)
                  : _approverEmpIdOK == false
                      ? Text('Enter 15 numerical digits, only. (e.g. 02075)',
                          style: warningTextStyle)
                      : Container(),

              const SizedBox(height: 20),

              // SUBMIT BUTTON
              Container(
                margin: const EdgeInsets.only(top: 30.0),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');

                    Map<String, dynamic> dataAdmin = {};

                    if (isInputDataOK()) {
                      dataAdmin = {
                        "empId": m_empId,
                        "approverEmpId": m_approverEmpId,
                        "active": false,
                      };
                    }
                    _controller.create(dataAdmin);
                    Get.off(() => const UserAdminScreen());
                  },
                  child: const Text('Submit'),
                ),
              ),

              //
            ]),
          ),
        ),
      ),

      //
    );
  }

  // METHODS

  bool isInputDataOK() {
    if (_isEmptyEmpID == false &&
        _empIDOK == true &&
        _isEmptyAproverEmpId == false &&
        _approverEmpIdOK == true) {
      return true;
    } else {
      return false;
    }
  }

  // VARIABLES

  TextStyle warningTextStyle =
      const TextStyle(color: Colors.red, fontSize: 9.0);

//
}
