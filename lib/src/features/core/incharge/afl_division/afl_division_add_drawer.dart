import 'package:afljms/src/features/core/incharge/controllers/afl_division_controller.dart';

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
  bool _IsEmptyDivName = true;

  final AFLDivisionController _controller = Get.put(AFLDivisionController());

  Set<SGSEnumActivation> _enumActivation = <SGSEnumActivation>{
    SGSEnumActivation.activate,
    // SGSEnumActivation.deactivate
  };

  final double _defaultInputWidth = 300.0;

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
                  textEditingController: _controller.divisionController,
                  title: 'Division Name',
                  hint: 'Division Name',
                  maxLength: 15,
                  width: _defaultInputWidth,
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
                          _controller.divisionActive = true;
                        } else {
                          _controller.divisionActive = false;
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
                    if (_controller.divisionController.text.trim() != "") {
                      // setState(() => _IsEmptyDivName = false);

                      _controller.create();

                      Get.back();
                    } else {
                      setState(() => _IsEmptyDivName = true);
                      return;
                    }
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
