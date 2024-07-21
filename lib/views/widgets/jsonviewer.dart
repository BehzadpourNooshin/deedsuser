import 'dart:convert';

import 'package:deedsuser/controllers/json_controller.dart';
import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_view/json_view.dart';

class MyJsonViewr extends StatelessWidget {
  const MyJsonViewr({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    JsonController jsonController = Get.put(JsonController());

    return Obx(() => jsonController.jsonText.value.isEmpty
        ? const Text('')
        : Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.all(kDefaultPadding * 2),
                child: Container(
                  width: Get.width / 3,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: kPrimaryColor),
                          top: BorderSide(color: kPrimaryColor)),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25))),
                  child: Padding(
                    padding: EdgeInsets.all(kDefaultPadding),
                    child: JsonViewBody(
                      styleScheme: JsonStyleScheme(
                          keysStyle: CustomTextStyle()
                              .textStyleDesktopCourierkBlackColor,
                          valuesStyle: CustomTextStyle()
                              .textStyleDesktopCourierkBlackColor,
                          openAtStart: true,
                          quotation: const JsonQuotation(
                              leftQuote: "", rightQuote: "")),
                      colorScheme: const JsonColorScheme(
                          markColor: kErrorColor,
                          numColor: kPrimaryColor,
                          boolColor: kPrimaryColor,
                          normalColor: kBlackColor,
                          stringColor: kPrimaryColor),
                      json: json.decode(jsonController.jsonText.value),
                    ),
                  ),
                ),
              ),
            ),
          ));
  }
}
