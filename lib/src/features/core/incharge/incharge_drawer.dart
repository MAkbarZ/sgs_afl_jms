import 'package:flutter/material.dart';

import '../../../theme/widget_theme/text_theme.dart';

class SGSInchargeDrawer extends StatefulWidget {
  final void Function()? onTapDashboard;
  // final void Function()? onTapManageDivision;
  final void Function()? onTapAFLDivision;
  final void Function()? onTapManageFunction;
  final String currentSelection;
  const SGSInchargeDrawer({
    super.key,
    this.onTapDashboard,
    // this.onTapManageDivision,
    this.onTapAFLDivision,
    this.onTapManageFunction,
    required this.currentSelection,
  });

  @override
  State<SGSInchargeDrawer> createState() => _SGSInchargeDrawerState();
}

class _SGSInchargeDrawerState extends State<SGSInchargeDrawer> {
  @override
  Widget build(BuildContext context) {
    // final InchargeController _inchargeController =
    //     Get.put(InchargeController());
    return SizedBox(
      width: 200.0,
      child: NavigationDrawer(
        backgroundColor: Colors.grey[200],
        children: [
          ListTile(
            leading: const Icon(Icons.home, size: 20.0),
            title: Container(
              decoration: widget.currentSelection == 'Dashboard'
                  ? _selectedDectoration
                  : null,
              child: Text(
                'Dashboard',
                style: SGSTextTheme.normalStyle13,
              ),
            ),
            // onTap: () {
            //   Get.offAll(() => const InchargeDashboard());
            // },
            onTap: widget.onTapDashboard,
          ),
          ListTile(
            leading: const Icon(Icons.hive, size: 20.0),
            title: Container(
              decoration: widget.currentSelection == 'AFL Division'
                  ? _selectedDectoration
                  : null,
              child: Text(
                'AFL Division',
                style: SGSTextTheme.normalStyle13,
              ),
            ),
            // onTap: widget.onTapManageDivision,
            onTap: widget.onTapAFLDivision,
          ),
          ListTile(
              // leading: const Icon(Icons.chat),
              leading: const Icon(Icons.workspaces, size: 20.0),
              title: Container(
                decoration: widget.currentSelection == 'AFL Function'
                    ? _selectedDectoration
                    : null,
                child: Text(
                  'AFL Function',
                  style: SGSTextTheme.normalStyle13,
                ),
              ),
              onTap: widget.onTapManageFunction),
          //   // DrawerHeader(child: Icon(Icons.favorite)),
          //   // const SizedBox(height: _gapHeight),

          //   // const SizedBox(height: _gapHeight),
          //   // ListTile(
          //   //   leading: Icon(Icons.settings),
          //   //   title: Text('Settings'),
          //   // ),
          //   // const SizedBox(height: _gapHeight),
          //   // ListTile(
          //   //   leading: Icon(Icons.phone),
          //   //   title: Text('Test 1'),
          //   // ),
          //   // const SizedBox(height: _gapHeight),
          //   // ListTile(
          //   //   leading: Icon(Icons.golf_course),
          //   //   title: Text('Test 2'),
          //   // ),
        ],
      ),
    );
  }

  final _selectedDectoration = const BoxDecoration(
      // color: Colors.grey,
      border: Border(
          left: BorderSide(
              color: Color.fromARGB(255, 255, 153, 102),
              width: 2.0,
              style: BorderStyle.solid)));
}
