import 'package:flutter/material.dart';
import '../theme/widget_theme/text_theme.dart';

class SGSInputDropDownMenu extends StatefulWidget {
  final String title;

  final Function(dynamic)? onChanged;
  final Function(String?)? onSelected;
  final List<String> itemList;
  final String itemSelected;
  final double dropdownWidth;

  const SGSInputDropDownMenu({
    super.key,
    required this.title,
    required this.onChanged,
    required this.itemList,
    this.onSelected,
    required this.itemSelected,
    required this.dropdownWidth,
  });

  @override
  State<SGSInputDropDownMenu> createState() => _SGSInputDropDownMenuState();
}

class _SGSInputDropDownMenuState extends State<SGSInputDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    // final _mediaQueryWidth = MediaQuery.of(context).size.width;

    return Column(
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
            ),
          ),

          Positioned(
            top: -9,
            left: 16,
            child:
                // SUFFIX ICON
                SizedBox(
              // width: 210.0,
              width: widget.dropdownWidth,

              // color: const Color.fromARGB(255, 189, 254, 191),

              // padding: const EdgeInsets.only(top: 12),
              // child: DropdownMenu<String>(
              //   initialSelection: widget.itemList.first,
              //   onSelected: widget.onSelected,
              //   dropdownMenuEntries: widget.itemList
              //       .map<DropdownMenuEntry<String>>((String value) {
              //     return DropdownMenuEntry<String>(value: value, label: value);
              //   }).toList(),

              //   inputDecorationTheme:
              //       const InputDecorationTheme(border: InputBorder.none),
              // ),
              child: DropdownButton(
                value: widget.itemSelected,
                padding: const EdgeInsets.only(right: 40.0),
                underline: Container(height: 0.0),
                elevation: 6,
                isExpanded: true,
                // isDense: true,
                // icon: const Icon(
                //   Icons.keyboard_arrow_down,
                //   // size: 20.0,
                //   color: Colors.grey,
                // ),
                iconSize: 20.0,
                style: SGSTextTheme.textInputStyle14,
                items: widget.itemList.map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: const TextStyle(fontSize: 11.0)),
                  );
                }).toList(),
                onChanged: widget.onChanged,
              ),
            ),
          ),

          //end of stack
        ]),
      ],
    );
  }

//
}
