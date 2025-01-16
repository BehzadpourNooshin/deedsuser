import 'dart:async';
import 'package:deedsuser/controllers/loginresponse_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:deedsuser/bindings/bindings.dart';
import 'package:deedsuser/route/routes.dart';
import 'package:idle_detector_wrapper/idle_detector_wrapper.dart';
import 'package:intl/intl.dart';


void main() {
  FlutterError.onError = (FlutterErrorDetails details) {};
  final farsiNumber = NumberFormat.decimalPattern('fa');
  // Disable Dart errors
  runZonedGuarded(
    () {
      runApp(MyApp());
    },
    (error, stackTrace) {
      // Do nothing with the error and stack trace
    },
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  LoginResponseController loginResponseController =
      Get.put(LoginResponseController());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return IdleDetector(
      idleTime: const Duration(minutes: 20),
      onIdle: () {
        loginResponseController.logout(0);
      },
      child: GetMaterialApp(
        //  theme: ThemeData(textTheme: GoogleFonts.montserratTextTheme()),
        theme: ThemeData(fontFamily: 'BNazanin'),
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.fadeIn,
        getPages: Routes.pages,
        initialBinding: MyBindings(),
        initialRoute: '/',
      ),
    );
  }

  static void changeColor(Color color, Brightness brightness) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color,
      statusBarIconBrightness: brightness,
    ));
  }
}
