import 'package:flutter/material.dart';

import '../theme/theme.dart';
import '../theme/widget_theme/text_theme.dart';

class SGSAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double screenWidth;
  final Function()? openDrawer;

  const SGSAppBar({
    super.key,
    required this.screenWidth,
    this.openDrawer,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.0,
      child: AppBar(
        backgroundColor: SGSAppTheme.primary,
        title: Text(
          title,
          // style: screenWidth < 350
          //     ? SGSTextTheme.titleStyle15.copyWith(fontSize: 14.0, color: Colors.white)
          //     : SGSTextTheme.titleStyle15.copyWith(fontSize: 14.0 , color: Colors.white),
          style: SGSTextTheme.titleStyle15
              .copyWith(fontSize: 14.0, color: Colors.white),
        ),
        leading: screenWidth < 550
            ? IconButton(
                onPressed: openDrawer,
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 20.0,
                ),
              )
            : null,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
