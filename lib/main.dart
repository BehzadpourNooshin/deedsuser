import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:deedsuser/bindings/bindings.dart';
import 'package:deedsuser/route/routes.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    // Do nothing with the error details
  };

  // Disable Dart errors
  runZonedGuarded(
    () {
      runApp(const MyApp());
    },
    (error, stackTrace) {
      // Do nothing with the error and stack trace
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //  theme: ThemeData(textTheme: GoogleFonts.montserratTextTheme()),
      theme: ThemeData(fontFamily: 'BNazanin'),
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fadeIn,
      getPages: Routes.pages,
      initialBinding: MyBindings(),
      initialRoute: '/',
    );
  }

  static void changeColor(Color color, Brightness brightness) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color,
      statusBarIconBrightness: brightness,
    ));
  }
}
