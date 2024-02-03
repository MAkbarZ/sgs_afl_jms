import 'package:flutter/material.dart';

import '../theme/theme.dart';
import '../theme/widget_theme/text_theme.dart';

class SGSInputField extends StatefulWidget {
  final String title;
  final String? hint;
  final String? supportingText;
  final TextEditingController? textEditingController;
  final Widget? suffixIcon;
  final int? maxLength;
  final String? Function(String?)? validator;
  // RxBool obscure = false.obs;
  final bool isObscure;
  final bool readonly;
  final Function(String)? onChanged;

  const SGSInputField({
    super.key,
    required this.title,
    this.hint,
    this.textEditingController,
    this.suffixIcon,
    this.maxLength,
    required this.isObscure,
    this.supportingText,
    this.validator,
    required this.readonly,
    this.onChanged,
  });

  @override
  State<SGSInputField> createState() => _SGSInputFieldState();
}

class _SGSInputFieldState extends State<SGSInputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //label
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            widget.title,
            style: SGSTextTheme.headingStyle12,
            textAlign: TextAlign.left,
          ),
        ),

        // textbox
        Stack(children: <Widget>[
          // border container
          Container(
            height: 30,
            margin: const EdgeInsets.only(top: 5.0, right: 15.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(4),
            ),
          ),

          Positioned(
            // width: double.infinity,
            // height: double.infinity,
            top: -7,
            // top: 0,
            left: 16,
            child: SizedBox(
              width: 260,
              height: 35,
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 30,
                      child: TextFormField(
                        enableSuggestions: false,
                        autocorrect: false,
                        // onTap: () {
                        //   const Focus(child: null,);
                        // },
                        // cursorHeight: 15,
                        obscureText: widget.isObscure,
                        maxLength: widget.maxLength,
                        // validator: widget.validator,
                        autofocus: false,
                        readOnly: widget.readonly,
                        cursorColor: SGSAppTheme.primary.withOpacity(0.7),
                        controller: widget.textEditingController,
                        style: SGSTextTheme.textInputStyle14,
                        decoration: InputDecoration(
                          hintText: widget.hint,
                          hintStyle: SGSTextTheme.textInputStyle12,
                          // errorText: 'hellow error.',
                          // errorStyle: SGSTextTheme.textInputHintStyleRed10,
                          // helperStyle: SGSTextTheme.textInputStyle10,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          // suffixIcon: widget.suffixIcon,
                          counterText: '',
                        ),
                        onChanged: widget.onChanged,
                      ),
                    ),
                  ),

                  // SUFFIX ICON
                  Container(
                      padding: const EdgeInsets.only(top: 12),
                      child: widget.suffixIcon),
                ],
              ),
            ),

            //end of positioned
          ),

          Positioned(
            right: 0,
            child: _counterWidget(widget.maxLength),
          ),

          //end of stack
        ]),
      ],
    );
  }

  Container _counterWidget(int? maxLength) {
    return maxLength == null
        ? Container()
        : Container(
            padding: const EdgeInsets.only(top: 15),
            child: Text(widget.maxLength.toString(),
                style: SGSTextTheme.normalStyle13
                    .copyWith(fontSize: 9, color: Colors.grey.shade500)),
          );
  }
}
