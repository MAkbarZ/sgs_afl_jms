import 'package:afljms/src/common_widgets/input_dropdown_menu.dart';
import 'package:afljms/src/enums/enums.dart';
import 'package:flutter/material.dart';
import '../../../common_widgets/input_field.dart';
import '../../../theme/theme.dart';
import '../../../theme/widget_theme/text_theme.dart';

class EmployeeRegisterScreenDesktop extends StatefulWidget {
  final Function(String)? onChangedEmplID;
  final Widget isEmpIDValid;
  final Function(Set<SGSEnumGender>)? onSelectionChangedGender;
  final Set<SGSEnumGender> selectedGender;
  final Function(String)? onChangedFullName;
  final Widget isFullNameValid;
  final Function(String)? onChangedPhoneNo;
  final Widget isPhoneNoValid;
  final Function(String)? onChangedMobileNo;
  final Widget isMobileNoValid;
  // final Function(String)? onChangedEmail;
  // final Widget isEmailValid;
  final Function()? onPressedHireDate;
  final Widget isHireDateValid;
  final Function(dynamic)? onChangedDivisions;
  final Function(String?)? onSelectedDivisions;
  final Widget isDivisionValid;
  final Function(dynamic)? onChangedFunctions;
  final Function(String?)? onSelectedFunctions;
  final Widget isFunctionValid;
  final bool isInputDataOK;
  final Function()? onPressedSubmit;
  final List<String> divisionList;
  final List<String> functionList;
  final String selectedDivison;
  final String selectedFunction;
  final String selectedHireDate;

  final String? initialValueEmail;

  const EmployeeRegisterScreenDesktop({
    super.key,
    this.onChangedEmplID,
    required this.isEmpIDValid,
    this.onSelectionChangedGender,
    this.onChangedFullName,
    required this.isFullNameValid,
    this.onChangedPhoneNo,
    required this.isPhoneNoValid,
    this.onChangedMobileNo,
    required this.isMobileNoValid,
    // this.onChangedEmail,
    // required this.isEmailValid,
    this.onPressedHireDate,
    required this.isHireDateValid,
    this.onChangedDivisions,
    required this.isDivisionValid,
    this.onChangedFunctions,
    required this.isFunctionValid,
    required this.isInputDataOK,
    this.onPressedSubmit,
    required this.functionList,
    required this.divisionList,
    required this.selectedDivison,
    required this.selectedFunction,
    required this.selectedHireDate,
    required this.selectedGender,
    this.initialValueEmail,
    this.onSelectedFunctions,
    this.onSelectedDivisions,
  });

  @override
  State<EmployeeRegisterScreenDesktop> createState() =>
      _EmployeeRegisterScreenStateMobile();
}

class _EmployeeRegisterScreenStateMobile
    extends State<EmployeeRegisterScreenDesktop> {
  final double _defaultInputWidth = 200.0;

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    final screenWidth = 600.0;

    return Container(
      padding: const EdgeInsets.all(30.0),
      width: screenWidth,
      color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // FIRST ROW
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              width: _defaultInputWidth,
              child: SGSInputField(
                title: 'Employee ID',
                hint: 'e.g. 02075',
                maxLength: 10,
                width: _defaultInputWidth,
                isObscure: false,
                readonly: false,
                onChanged: widget.onChangedEmplID,
              ),
            ),
            widget.isEmpIDValid,
          ]),
          const SizedBox(width: 20.0),

          // GENDER
          Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      'Gender',
                      style: SGSTextTheme.headingStyle12,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  // ACTIVE SEGMENTED BUTTON
                  SizedBox(
                    // width: 20,
                    height: 25,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: SegmentedButton<SGSEnumGender>(
                        segments: const [
                          ButtonSegment<SGSEnumGender>(
                              value: SGSEnumGender.male, label: Text('Male')),
                          // ButtonSegment(
                          //     value: 'Month', label: Text('Month')),
                          ButtonSegment<SGSEnumGender>(
                              value: SGSEnumGender.female,
                              label: Text('Female')),
                        ],
                        onSelectionChanged: widget.onSelectionChangedGender,
                        selected: widget.selectedGender,
                        emptySelectionAllowed: false,
                        multiSelectionEnabled: false,
                      ),
                    ),
                  ),
                ]),
          ),

          // end of 1st Row
        ]),

        const SizedBox(height: 5.0),

        // Full Name
        SizedBox(
          // width: double.infinity,
          width: screenWidth - 300,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SGSInputField(
              title: 'Full Name',
              hint: 'Enter your full name',
              isObscure: false,
              readonly: false,
              maxLength: 25,
              width: _defaultInputWidth,
              // textEditingController:
              //     _controller.fullNameController,
              // isObscure: false,
              onChanged: widget.onChangedFullName,
            ),
            widget.isFullNameValid,
          ]),
        ),
        const SizedBox(height: 15.0),

        // 3RD ROW
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Phone No.
            SizedBox(
              width: _defaultInputWidth,
              child: SGSInputField(
                title: 'Phone No.',
                hint: 'e.g. 020111999222314',
                maxLength: 15,
                width: _defaultInputWidth,
                isObscure: false,
                readonly: false,
                onChanged: widget.onChangedPhoneNo,
              ),
            ),
            widget.isPhoneNoValid,
          ]),
          const SizedBox(width: 20.0),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Mobile No.
            SizedBox(
              width: _defaultInputWidth,
              child: SGSInputField(
                title: 'Mobile No.',
                hint: 'e.g. 03138476361',
                maxLength: 11,
                width: _defaultInputWidth,
                isObscure: false,
                readonly: false,
                onChanged: widget.onChangedMobileNo,
              ),
            ),
            widget.isMobileNoValid,
          ])
        ]),
        const SizedBox(height: 5.0),

        // 4TH ROW
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Email
            SizedBox(
              width: _defaultInputWidth,
              child: SGSInputField(
                title: 'Email',
                hint: 'Enter your email',
                readonly: true,
                disabledColor: SGSAppTheme.disabledTextBG,
                isObscure: false,
                maxLength: 25,
                width: _defaultInputWidth,
                initialValue: widget.initialValueEmail,
                // onChanged: widget.onChangedEmail,
              ),
            ),
            // widget.isEmailValid,
          ]),
          const SizedBox(width: 20.0),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Hired Date
            SizedBox(
              width: _defaultInputWidth,
              child: SGSInputField(
                title: 'Hired Date',
                hint: widget.selectedHireDate,
                readonly: true,
                isObscure: false,
                // maxLength: 25,
                width: _defaultInputWidth,
                suffixIcon: IconButton(
                  // hoverColor: Colors.grey,
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    size: 15.0,
                    color: Colors.grey,
                  ),
                  // onPressed: () => _signUpController.toggleShowHidePassword(),
                  onPressed: widget.onPressedHireDate,
                ),
              ),
            ),
            widget.isHireDateValid,
          ])
        ]),
        const SizedBox(height: 5.0),

        // 4TH ROW
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              width: _defaultInputWidth,
              // AFL DIVISION
              // const SizedBox(height: 5.0),
              // SGSInputField(
              //   title: 'AFL Division',
              //   hint: widget.selectedDivison,
              //   // maxLength: 20,
              //   width: _defaultInputWidth,
              //   readonly: true,
              //   isObscure: false,
              //   suffixIcon: Container(
              //     color: Colors.blue,
              //     child: DropdownButton(
              //         // padding: const EdgeInsets.only(right: 8.0),
              //         underline: Container(height: 0.0),
              //         elevation: 4,
              //         // itemHeight: 50.0,
              //         // selectedItemBuilder: ,
              //         isDense: true,
              //         icon: const Icon(
              //           Icons.keyboard_arrow_down,
              //           // size: 20.0,
              //           color: Colors.grey,
              //         ),
              //         iconSize: 20.0,
              //         // iconSize: 32,
              //         style: SGSTextTheme.textInputStyle14,
              //         items: widget.divisionList
              //             .map<DropdownMenuItem<String>>((value) {
              //           return DropdownMenuItem<String>(
              //             value: value,
              //             child:
              //                 Text(value, style: const TextStyle(fontSize: 11.0)),
              //           );
              //         }).toList(),
              //         onChanged: widget.onChangedDivisions),
              //   ),
              // ),
              // widget.isDivisionValid,
              child: SGSInputDropDownMenu(
                title: 'AFL Division',
                onChanged: widget.onChangedDivisions,
                itemList: widget.divisionList,
                itemSelected: widget.selectedDivison,
                onSelected: widget.onSelectedDivisions,
                dropdownWidth: _defaultInputWidth,
              ),
            ),
          ]),
          const SizedBox(width: 20.0),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Hired Date
            SizedBox(
              width: _defaultInputWidth,
              child:
                  // AFL FUNCTION
                  SGSInputDropDownMenu(
                title: 'AFL Function',
                onChanged: widget.onChangedFunctions,
                itemList: widget.functionList,
                itemSelected: widget.selectedFunction,
                onSelected: widget.onSelectedFunctions,
                dropdownWidth: _defaultInputWidth,
              ),
              // widget.isFunctionValid,
            ),
          ])
        ]),

        const SizedBox(height: 25.0),

        // SUBMIT BUTTON
        SizedBox(
          width: 200.0,
          child: ElevatedButton(
            onPressed: widget.onPressedSubmit,
            child: const Text('Submit'),
          ),
        ),
      ]),
    );
  }

//
}
