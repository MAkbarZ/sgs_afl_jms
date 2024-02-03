import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/input_field.dart';
import '../../../../enums/enums.dart';

class AFLFunctionAdd extends StatefulWidget {
  const AFLFunctionAdd({
    super.key,
  });

  @override
  State<AFLFunctionAdd> createState() => _AFLFunctionAddState();
}

class _AFLFunctionAddState extends State<AFLFunctionAdd> {
  final _collection = FirebaseFirestore.instance.collection('afl_function');

  bool _functionActive = true;
  bool _IsEmptyFunctionName = true;

  TextEditingController functionNameController = TextEditingController();

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
          title: const Text('Add New AFL Function'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SGSInputField(
                  textEditingController: functionNameController,
                  title: 'Function Name',
                  hint: 'Function Name',
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
                        setState(() => _IsEmptyFunctionName = false);
                      } else {
                        setState(() => _IsEmptyFunctionName = true);
                        return;
                      }
                    });
                  }),
              _IsEmptyFunctionName
                  ? const Text("Function Name cannot be empty.",
                      style: TextStyle(color: Colors.red, fontSize: 9.0))
                  : Container(),
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
                        if (selected.elementAt(0) ==
                            SGSEnumActivation.activate) {
                          _functionActive = true;
                        } else {
                          _functionActive = false;
                        }
                        _enumActivation = selected;
                      });

                      // print(_functionActive);
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
                    // print(functionNameController.text.trim());
                    // print(_functionActive);
                    var _functionName = "";
                    if (functionNameController.text.trim() != "") {
                      _functionName = functionNameController.text.trim();

                      // setState(() => _IsEmptyFunctionName = false);

                      _collection.doc(functionNameController.text.trim()).set({
                        "functionName": functionNameController.text.trim(),
                        "active": _functionActive,
                      });
                      Get.back();
                    } else {
                      setState(() => _IsEmptyFunctionName = true);
                      return;
                    }

                    // print(_functionName);
                    // print(_functionActive);
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
