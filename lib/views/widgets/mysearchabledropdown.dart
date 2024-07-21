import 'package:deedsuser/controllers/dropdown_controller.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';

class MySearchableDropDown extends StatelessWidget {
  final String labelTitle;
  final String hintTitle;
  final String errorTitle;
  final TextEditingController myController;
  final List myItems;
  final String nameDropDown;
  final DropdownController controller;

  const MySearchableDropDown(
      {super.key,
      required this.labelTitle,
      required this.hintTitle,
      required this.controller,
      this.errorTitle = "",
      this.myItems = const [],
      required this.myController,
      required this.nameDropDown});

  @override
  Widget build(BuildContext context) {
    List<String> myItemsString = [];
    for (var item in myItems) {
      myItemsString.add(item.toString());
    }
    return DropdownSearch<String>(
      clearButtonProps: ClearButtonProps(
          // onPressed: () {
          //   myController.text = '';
          //   controller.resetDropdown(nameDropDown);
          //   controller.update();
          // },
          icon: const Icon(Icons.clear),
          iconSize: SideMenuConstant().iconSize,
          isVisible: true,
          alignment: Alignment.center),
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
            //  border: const OutlineInputBorder(),
          ),
        ),
      ),
      items: myItemsString,
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
      onChanged: (String? value) {
        myController.text = value ?? '';
        controller.setSelectedItem(nameDropDown, value.toString());
      },
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return errorTitle;
        }
        return null;
      },
    );
  }
}
