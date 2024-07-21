import 'package:deedsuser/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawHeaderSideBar extends StatelessWidget {
  const MyDrawHeaderSideBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
        curve: Curves.fastOutSlowIn,
        decoration: const BoxDecoration(
            //backgroundBlendMode: BlendMode.overlay,
            color: kPrimaryColor,
            image: DecorationImage(
              image: AssetImage("assets/images/Icon-Invert-512.png"),
            )),
        child: Container(
          height: Get.height / 2,
        ));
  }
}
