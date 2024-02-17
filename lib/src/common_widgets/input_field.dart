import 'package:flutter/material.dart';

import '../theme/theme.dart';
import '../theme/widget_theme/text_theme.dart';

class SGSInputField extends StatefulWidget {
  final String title;
  final String? hint;
  final String? supportingText;
  final TextEditingController? textEditingController;
  final Widget? suffixIcon;
  final double width;
  final int? maxLength;
  final String? Function(String?)? validator;
  // RxBool obscure = false.obs;
  final bool isObscure;
  final bool readonly;
  final Function(String)? onChanged;
  final String? initialValue;
  final Color? disabledColor;

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
    this.initialValue,
    required this.width,
    this.disabledColor,
  });

  @override
  State<SGSInputField> createState() => _SGSInputFieldState();
}

class _SGSInputFieldState extends State<SGSInputField> {
  @override
  Widget build(BuildContext context) {
    // final _mediaQueryWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //label
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              widget.title,
              style: SGSTextTheme.headingStyle11,
              textAlign: TextAlign.left,
            ),
          ),

          // textbox
          Stack(children: <Widget>[
            // border container
            Container(
              height: 23,
              margin: const EdgeInsets.only(top: 5.0, right: 15.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(4),
                color: widget.disabledColor,
              ),
            ),

            Positioned(
              top: 0,
              left: 16,
              child: Container(
                height: 25,
                width: widget.width,
                // color: Colors.yellow,
                child: TextFormField(
                  enableSuggestions: false,
                  autocorrect: false,
                  initialValue: widget.initialValue,

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
                  style: SGSTextTheme.textInputStyle12,
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

            Positioned(
              top: 1,
              right: 18,
              child:
                  // SUFFIX ICON
                  Container(
                // color: const Color.fromARGB(255, 189, 254, 191),
                height: 30.0,
                width: 30.0,
                // padding: const EdgeInsets.only(top: 12),
                child: widget.suffixIcon,
              ),
            ),

            Positioned(
              top: -4,
              right: 0,
              child:
                  // COUNTER
                  Container(
                // color: const Color.fromARGB(255, 255, 171, 199),
                height: 30,
                width: 20.0,
                child: _counterWidget(widget.maxLength),
              ),
            ),

            //end of stack
          ]),
        ],
      ),
    );
  }

  Container _counterWidget(int? maxLength) {
    return maxLength == null
        ? Container(width: 15)
        : Container(
            padding: const EdgeInsets.only(top: 15),
            child: Text(widget.maxLength.toString(),
                textAlign: TextAlign.right,
                style: SGSTextTheme.normalStyle13
                    .copyWith(fontSize: 9, color: Colors.grey.shade500)),
          );
  }
}
