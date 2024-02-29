import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../common_widgets/input_dropdown_menu.dart';
import '../../../common_widgets/input_field.dart';
import '../../../enums/enums.dart';
import '../../../utils/text_input_validator.dart';
import '../controllers/controller_employee_auth.dart';

class EmployeeAuthorityAdd extends StatefulWidget {
  const EmployeeAuthorityAdd({
    super.key,
  });

  @override
  State<EmployeeAuthorityAdd> createState() => _EmployeeAuthorityAddState();
}

class _EmployeeAuthorityAddState extends State<EmployeeAuthorityAdd> {
  final EmployeeAuthorityController _controller =
      Get.put(EmployeeAuthorityController());

  Set<SGSEnumActivation> _enumActivation = <SGSEnumActivation>{
    SGSEnumActivation.activate,
    // SGSEnumActivation.deactivate
  };

  final double _defaultInputWidth = 300.0;

  @override
  void initState() {
    super.initState();

    getAllActiveDivisions();
    getAllActiveFunctions();
    getAllDBRoles();

    // _controller.authority.active = true;
  }

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
              // Get.to(() => const InchargeDashboard(),
              //     transition: Transition.leftToRight);
            }),
        title: const Text('Add New Employee Authority'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(30.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SGSInputField(
              title: 'Employee ID',
              hint: 'e.g. 2075',
              maxLength: 9,
              width: _defaultInputWidth,
              readonly: false,
              isObscure: false,
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.search,
                  size: 15.0,
                  color: Colors.grey,
                ),
                onPressed: () {
                  // SEARCH DB FOR THE EMPLOYEE AND
                },
              ),
              onChanged: onChangedEmplID,
            ),
            Validator()
                .isEmpIDValid(_controller.isEmptyEmpID, _controller.empIDOK),

            const SizedBox(height: 20),

            SGSInputDropDownMenu(
              title: 'AFL Division',
              onChanged: onChangedDivisions,
              itemList: _controller.divList,
              itemSelected: _controller.selectedDivison,
              onSelected: onSelectedDivisions,
              dropdownWidth: _defaultInputWidth - 60,
            ),
            // isDivisionValid(),

            const SizedBox(height: 20),

            SGSInputDropDownMenu(
              title: 'AFL Function',
              onChanged: onChangedFunctions,
              itemList: _controller.functionList,
              itemSelected: _controller.selectedFunction,
              onSelected: onSelectedFunctions,
              dropdownWidth: _defaultInputWidth - 60,
            ),
            // isDivisionValid(),

            const SizedBox(height: 20),

            SGSInputDropDownMenu(
              title: 'DB Access Role',
              onChanged: onChangedDBRole,
              itemList: _controller.dbRoleList,
              itemSelected: _controller.selectedDBRole,
              onSelected: onSelectedDBRole,
              dropdownWidth: _defaultInputWidth - 60,
            ),
            // isDivisionValid(),

            const SizedBox(height: 20),

            // ACTIVE SEGMENTED BUTTON
            SizedBox(
              // width: 20,
              height: 30,
              child: FittedBox(
                fit: BoxFit.fill,
                child: SegmentedButton<SGSEnumActivation>(
                  segments: const [
                    ButtonSegment<SGSEnumActivation>(
                        value: SGSEnumActivation.activate,
                        label: Text('Activate')),
                    // ButtonSegment(
                    //     value: 'Month', label: Text('Month')),
                    ButtonSegment<SGSEnumActivation>(
                        value: SGSEnumActivation.deactivate,
                        label: Text('Deactivate')),
                  ],
                  onSelectionChanged: (selected) {
                    // print('Selected $selected');
                    // print('Selected 0 ${selected.elementAt(0)}');
                    setState(() {
                      if (selected.elementAt(0) == SGSEnumActivation.activate) {
                        _controller.authority.active = true;
                      } else {
                        _controller.authority.active = false;
                      }
                      _enumActivation = selected;
                    });

                    // print(_divisionActive);
                  },
                  selected: _enumActivation,
                  emptySelectionAllowed: false,
                  multiSelectionEnabled: false,
                ),
              ),
            ),

            const SizedBox(height: 50),

            // SUBMIT BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                  // print(divisionController.text.trim());
                  // print(_divisionActive);
                  // if (_controller.divisionController.text.trim() != "") {
                  //   // setState(() => _isEmptyDivName = false);

                  _controller.onSubmit();

                  Get.back();
                  // } else {
                  //   setState(() => _isEmptyDivName = true);
                  //   return;
                  // }
                },
                child: const Text('Submit'),
              ),
            ),

            //
          ]),
        ),
      ),
    );
  }

  getAllActiveDivisions() async {
    _controller.divList.clear();
    await _controller.getActiveAFLDivisions().then((querySnapshot) {
      // print("Successfully completed");
      // int x = 0;
      for (var docSnapshot in querySnapshot.docs) {
        // print('${docSnapshot.id} => ${docSnapshot.data()}');
        // list.add({docSnapshot.id: docSnapshot.data()});
        _controller.divList.add(docSnapshot.data()['divisionName']);

        // print(_controller.divList[x]);
        // x++;
      }
      setState(() {
        _controller.selectedDivison = _controller.divList.first;
        _controller.authority.aflDivision = _controller.selectedDivison;
        _controller.isSelectedDivison = true;
        // print(_divList.first);
      });
    });
  }

  getAllActiveFunctions() async {
    _controller.functionList.clear();
    await _controller.getActiveAFLFunctions().then((querySnapshot) {
      // print("Successfully completed");

      for (var docSnapshot in querySnapshot.docs) {
        // print('${docSnapshot.id} => ${docSnapshot.data()}');
        // list.add({docSnapshot.id: docSnapshot.data()});

        _controller.functionList.add(docSnapshot.data()['functionName']);
      }
      setState(() {
        _controller.selectedFunction = _controller.functionList.first;
        _controller.authority.aflFunction = _controller.selectedFunction;
        _controller.isSelectedFunction = true;
      });
      // print(_divList);
    });
  }

  getAllDBRoles() {
    setState(() {
      _controller.selectedDBRole = _controller.dbRoleList.first;
      _controller.authority.dbRole = _controller.selectedDBRole;
      _controller.isSelectedDBRole = true;
    });
    // print(_divList);
  }

  TextStyle warningTextStyle =
      const TextStyle(color: Colors.red, fontSize: 9.0);

  void onChangedEmplID(textValue) {
    if (textValue.trim() != "") {
      setState(() {
        _controller.isEmptyEmpID = false;

        _controller.empIDOK = Validator().isEmployeeID(textValue);
        if (_controller.isEmptyEmpID == false && _controller.empIDOK == true) {
          _controller.authority.empId = textValue.trim();
        } else {
          _controller.authority.empId = "";
        }
      });
    } else {
      setState(() => _controller.isEmptyEmpID = true);
      return;
    }
  }

  void onChangedDivisions(dynamic value) {
    if (value != null || value.toString() != "") {
      setState(() {
        _controller.selectedDivison = value.toString();
        _controller.authority.aflDivision = value.toString();
        _controller.isSelectedDivison = true;
      });
    } else {
      setState(() {
        _controller.selectedDivison = "Enter your AFL Division";
        _controller.authority.aflDivision = "";
        _controller.isSelectedDivison = false;
      });
    }
  }

  void onChangedFunctions(dynamic value) {
    if (value != null || value.toString() != "") {
      setState(() {
        _controller.selectedFunction = value.toString();
        _controller.authority.aflFunction = value.toString();
        _controller.isSelectedFunction = true;
      });
    } else {
      setState(() {
        _controller.selectedFunction = "Enter your AFL Function";
        _controller.authority.aflFunction = "";
        _controller.isSelectedFunction = false;
      });
    }
  }

  void onChangedDBRole(dynamic value) {
    if (value != null || value.toString() != "") {
      setState(() {
        _controller.selectedDBRole = value.toString();
        _controller.authority.dbRole = value.toString();
        _controller.isSelectedDBRole = true;
      });
    } else {
      setState(() {
        _controller.selectedDBRole = "Enter your DB Access Role";
        _controller.authority.dbRole = "";
        _controller.isSelectedDBRole = false;
      });
    }
  }

  void onSelectedDivisions(String? value) {
    if (value != null || value != "") {
      setState(() {
        _controller.selectedDivison = value.toString();
        _controller.isSelectedDivison = true;
      });
    } else {
      setState(() {
        _controller.selectedDivison = "Enter your AFL Division";
        _controller.isSelectedDivison = false;
      });
    }
  }

  void onSelectedFunctions(String? value) {
    if (value != null || value != "") {
      setState(() {
        _controller.selectedFunction = value.toString();
        _controller.isSelectedFunction = true;
      });
    } else {
      setState(() {
        _controller.selectedFunction = "Enter your AFL Function";
        _controller.isSelectedFunction = false;
      });
    }
  }

  void onSelectedDBRole(String? value) {
    if (value != null || value != "") {
      setState(() {
        _controller.selectedDBRole = value.toString();
        _controller.isSelectedDBRole = true;
      });
    } else {
      setState(() {
        _controller.selectedDBRole = "Enter your DB Access Role";
        _controller.isSelectedDBRole = false;
      });
    }
  }

  //
}
