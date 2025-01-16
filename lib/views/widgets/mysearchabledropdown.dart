import 'package:deedsuser/controllers/dropdown_controller.dart';
import 'package:deedsuser/controllers/loginresponse_controller.dart';
import 'package:deedsuser/functions/finddisplaytitle.dart';
import 'package:deedsuser/functions/matchingchildlookup.dart';
import 'package:deedsuser/functions/matchingparentlookup.dart';
import 'package:deedsuser/utils/api_service.dart';
import 'package:deedsuser/views/widgets/persiannumbertext.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:get/get.dart';

class MySearchableDropDown extends StatelessWidget {
  final String labelTitle;
  final String hintTitle;
  final String errorTitle;
  final TextEditingController myController;
  final RxList<String> myItems; // لیست واکنشی
  final String nameDropDown;
  final String lookupname;
  final DropdownController controller;

  const MySearchableDropDown({
    super.key,
    required this.labelTitle,
    required this.hintTitle,
    required this.controller,
    required this.lookupname,
    this.errorTitle = "",
    required this.myItems,
    required this.myController,
    required this.nameDropDown,
  });

  @override
  Widget build(BuildContext context) {
    LoginResponseController loginResponseController =
        Get.put(LoginResponseController());

    return Obx(() {
      return DropdownSearch<String>(
        clearButtonProps: ClearButtonProps(
          icon: const Icon(Icons.clear),
          iconSize: SideMenuConstant().iconSize,
          isVisible: true,
          alignment: Alignment.center,
        ),
        popupProps: PopupProps.menu(
          itemBuilder: (context, item, isSelected) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  item.toString(),
                  style: Responsive.isDesktop(context)
                      ? CustomTextStyle().textStyleDesktopkSecondrayColor
                      : CustomTextStyle().textStyleTabletkSecondrayColor,
                ),
              ),
            );
          },
          menuProps: const MenuProps(
            backgroundColor: kCardColor,
            elevation: 0,
          ),
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            textAlign: TextAlign.right,
            style: Responsive.isDesktop(context)
                ? CustomTextStyle().textStyleDesktopkSecondrayColor
                : CustomTextStyle().textStyleTabletkSecondrayColor,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              floatingLabelAlignment: FloatingLabelAlignment.center,
              alignLabelWithHint: true,
              label: Text(GeneralConstant().searchText,
                  style: Responsive.isDesktop(context)
                      ? CustomTextStyle().textStyleDesktopkSecondrayColor
                      : CustomTextStyle().textStyleTabletkSecondrayColor),
            ),
          ),
          emptyBuilder: (context, searchEntry) {
            return Center(
              child: Text(
                GeneralConstant().noDataFound,
                style: Responsive.isDesktop(context)
                    ? CustomTextStyle().textStyleTabletkSecondrayColor
                    : CustomTextStyle().textStyleTabletkSecondrayColor,
              ),
            );
          },
        ),
        items: myItems.toList(),
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: Responsive.isDesktop(context)
              ? CustomTextStyle().textStyleTabletkSecondrayColor
              : CustomTextStyle().textStyleTabletkSecondrayColor,
          textAlign: TextAlign.right,
          dropdownSearchDecoration: InputDecoration(
            fillColor: kCardColor,
            hintTextDirection: TextDirection.rtl,
            prefixIcon: Padding(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              child: Icon(
                Icons.search,
                size: SideMenuConstant().iconSize,
              ),
            ),
            floatingLabelAlignment: FloatingLabelAlignment.center,
            alignLabelWithHint: true,
            border: const OutlineInputBorder(),
            labelText: labelTitle,
            labelStyle: Responsive.isDesktop(context)
                ? CustomTextStyle().textStyleDesktopkSecondrayColor
                : CustomTextStyle().textStyleTabletkSecondrayColor,
            hintText: hintTitle,
            hintStyle: Responsive.isDesktop(context)
                ? CustomTextStyle().textStyleDesktopkSecondrayColor
                : CustomTextStyle().textStyleTabletkSecondrayColor,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kErrorColor),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kErrorColor),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kBlackColor),
            ),
            errorStyle: Responsive.isDesktop(context)
                ? CustomTextStyle().textStyleDesktopKerrorColor
                : CustomTextStyle().textStyleTabletKerrorColor,
          ),
        ),
        onChanged: (String? value) async {
          int idx = -1;
          myController.text = value ?? '';
          controller.setSelectedItem(nameDropDown, value.toString());

          // عملکرد مربوط به `lookupname`
          if (mathParentLookupWithList(lookupname)) {
            idx = findChildLookupIdx(lookupname);
          }

          if (idx != -1) {
            await Network().refreshToken();

            myController.text != ''
                ? {
                    await Network().getItemChild(
                      accessToken: loginResponseController.accesstoken.text,
                      index: idx,
                      parentGroupName: lookupname,
                      parentTitle:
                          findDisplayTitle(value.toString(), lookupname),
                      groupName: findChildLookupName(idx),
                    )
                  }
                : {
                    await Network().getAllItemChild(
                      accessToken: loginResponseController.accesstoken.text,
                      index: idx,
                      groupName: findChildLookupName(idx),
                    )
                  };
          }
        },
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return errorTitle;
          }
          return null;
        },
      );
    });
  }
}
