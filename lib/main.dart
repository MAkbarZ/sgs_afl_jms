import 'package:firebase_core/firebase_core.dart';
import 'package:afljms/firebase_options.dart';
import 'package:flutter/material.dart';
// import 'package:afl_jms/src/utils/theme/theme.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'src/backend/authentication/authentication_backend.dart';
import 'src/common_widgets/horizontal_scroll.dart';
import 'src/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationBackEnd()));
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Hello World',
        debugShowCheckedModeBanner: false,
        scrollBehavior: SGSHorizontalScroll(),
        // theme: ThemeData(
        //   useMaterial3: true,
        //   primarySwatch: Colors.blue,
        // ),
        // A widget which will be started on application startup
        theme: SGSAppTheme.theme,
        themeMode: ThemeMode.light,
        defaultTransition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 300),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        home: const SafeArea(
            child: Scaffold(body: Center(child: CircularProgressIndicator()))));

    //
  }
}
