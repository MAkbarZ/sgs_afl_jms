import 'package:flutter/material.dart';

class SearchTextBoxWidget extends StatelessWidget {
  final Function(String)? onChanged;

  const SearchTextBoxWidget({
    super.key,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    var borderColor = const Color.fromARGB(255, 216, 216, 216);
    return SizedBox(
        height: 30,
        child: TextField(
          style: const TextStyle(fontSize: 15.0),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              // borderSide: BorderSide.none,
              borderSide: BorderSide(
                color: borderColor,
                style: BorderStyle.solid,
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              // borderSide: BorderSide.none,
              borderSide: BorderSide(
                color: borderColor,
                style: BorderStyle.solid,
                width: 2.0,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              // borderSide: BorderSide.none,
              borderSide: BorderSide(
                color: borderColor,
                style: BorderStyle.solid,
                width: 2.0,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            filled: true,
            fillColor: const Color.fromARGB(255, 235, 235, 235),
            hintText: 'Search',
            hintStyle: const TextStyle(
                color: Color.fromARGB(255, 139, 139, 139), fontSize: 15.0),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.grey,
              size: 18.0,
            ),
          ),
          onChanged: onChanged,
        ));
  }
}
