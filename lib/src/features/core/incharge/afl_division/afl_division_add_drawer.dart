import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/input_field.dart';
import '../../../../enums/enums.dart';

class AFLDivisionAdd extends StatefulWidget {
  const AFLDivisionAdd({
    super.key,
  });

  @override
  State<AFLDivisionAdd> createState() => _AFLDivisionAddState();
}

class _AFLDivisionAddState extends State<AFLDivisionAdd> {
  final _collection = FirebaseFirestore.instance.collection('afl_division');

  bool _divisionActive = true;
  bool _IsEmptyDivName = true;

  TextEditingController divisionController = TextEditingController();

  Set<SGSEnumActivation> _enumActivation = <SGSEnumActivation>{
    SGSEnumActivation.activate,
    // SGSEnumActivation.deactivate
  };

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
          title: const Text('Add New AFL Devision'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SGSInputField(
                  textEditingController: divisionController,
                  title: 'Division Name',
                  hint: 'Division Name',
                  maxLength: 15,
                  readonly: false,
                  isObscure: false,
                  // suffixIcon: IconButton(
                  //   icon: const Icon(Icons.search, size: 15.0),
                  //   onPressed: () {},
                  // ),
                  onChanged: (textValue) {
                    setState(() {
                      if (textValue.trim() != "") {
                        setState(() => _IsEmptyDivName = false);
                      } else {
                        setState(() => _IsEmptyDivName = true);
                        return;
                      }
                    });
                  }),
              _IsEmptyDivName
                  ? const Text("Division Name cannot be empty.",
                      style: TextStyle(color: Colors.red, fontSize: 9.0))
                  : Container(),
              const SizedBox(height: 20),

              // ACTIVE SWITCH
              // SizedBox(
              //   // width: 20,
              //   height: 20,
              //   child: FittedBox(
              //     fit: BoxFit.fill,
              //     child: GetBuilder<InchargeController>(
              //       id: 'activeDivisionSwitch',
              //       builder: (_) => Switch(
              //           // value: divisionData.active,
              //           value: _inchargeController.divisionActive,
              //           onChanged: (bool currentValue) {
              //             // print('currentValue $currentValue');
              //             _inchargeController
              //                 .changeDivisionSwitchState(
              //                     currentValue);

              //             _inchargeController.activeController.text =
              //                 currentValue.toString();
              //             // print('activeController  ${_inchargeController.activeController.text}');
              //           }),
              //     ),
              //   ),
              // ),

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
                        if (selected.elementAt(0) ==
                            SGSEnumActivation.activate) {
                          _divisionActive = true;
                        } else {
                          _divisionActive = false;
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
                    var _divisionName = "";
                    if (divisionController.text.trim() != "") {
                      _divisionName = divisionController.text.trim();

                      // setState(() => _IsEmptyDivName = false);

                      _collection.doc(divisionController.text.trim()).set({
                        "divisionName": divisionController.text.trim(),
                        "active": _divisionActive,
                      });
                      Get.back();
                    } else {
                      setState(() => _IsEmptyDivName = true);
                      return;
                    }

                    // print(_divisionName);
                    // print(_divisionActive);
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
}
