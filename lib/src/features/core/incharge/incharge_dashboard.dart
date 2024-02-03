import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common_widgets/app_bar.dart';
import 'afl_division/afl_division_screen.dart';
import 'afl_function/afl_function_screen.dart';
import 'incharge.dart';

// import 'package:convert/convert.dart';
// import 'dart:convert';
// import 'package:crypto/crypto.dart';

class InchargeDashboard extends StatefulWidget {
  const InchargeDashboard({super.key});

  // @override
  // init() {
  //   _openChild()
  // }

  @override
  State<InchargeDashboard> createState() => _InchargeDashboardState();
}

class _InchargeDashboardState extends State<InchargeDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey(); // Create a key

  // final InchargeController _inchargeController = Get.put(InchargeController());

  String _currentChild = 'Dashboard';

  static const String _dashboard = 'Dashboard';
  // static const String _manageDivision = 'Manage Division';
  static const String _aflDivision = 'AFL Division';
  static const String _aflFunction = 'AFL Function';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: SGSAppBar(
          title: 'INCHARGE', screenWidth: screenWidth, openDrawer: _openDrawer),
      backgroundColor: Colors.grey[300],
      drawer: screenWidth < 550
          ? SGSInchargeDrawer(
              onTapDashboard: () => _openChild(_dashboard),
              // onTapManageDivision: () => _openChild(_manageDivision),
              onTapAFLDivision: () => _openChild(_aflDivision),
              onTapManageFunction: () => _openChild(_aflFunction),
              currentSelection: _currentChild,
            )
          : null,
      body: Row(
        children: [
          SizedBox(
            // width: 260.0,
            child: screenWidth >= 550
                ? SGSInchargeDrawer(
                    onTapDashboard: () => _openChild(_dashboard),
                    // onTapManageDivision: () => _openChild(_manageDivision),
                    onTapAFLDivision: () => _openChild(_aflDivision),
                    onTapManageFunction: () => _openChild(_aflFunction),
                    currentSelection: _currentChild,
                  )
                : null,
          ),

          // body of Dashbaoard
          Expanded(
              child: Container(
            // color: Colors.indigoAccent,
            // child: _currentChild == _manageDivision
            // child: _currentChild == _manageDivision
            child: _currentChild == _aflDivision
                ? const AFLDivisionScreen()
                : (_currentChild == _aflFunction
                    ? const AFLFunctionScreen()
                    : Container(color: Colors.indigoAccent)),
          )),
        ],
      ),
    );
  }

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  void _openChild(String selected) {
    setState(() {
      _currentChild = selected;
      Get.back();
    });
  }
}
