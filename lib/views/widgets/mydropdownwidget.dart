import 'package:deedsuser/controllers/dropdown_controller.dart';
import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:flutter/material.dart';

class MyFormBuilderDropdown extends StatelessWidget {
  final String labelTitle;
  final String nameDropDown;
  final String hintTitle;
  final String errorTitle;
  final TextEditingController myController;
  final List myItems;
  final DropdownController controller;

  const MyFormBuilderDropdown(
      {super.key,
      required this.labelTitle,
      required this.nameDropDown,
      required this.hintTitle,
      required this.controller,
      this.errorTitle = "",
      this.myItems = const [],
      required this.myController});
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        hint: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              hintTitle,
              style: Responsive.isDesktop(context)
                  ? CustomTextStyle().textStyleDesktopkSecondrayColor
                  : CustomTextStyle().textStyleTabletkSecondrayColor,
            )
          ],
        ),
        // isExpanded: true,
        focusColor: kCardColor.withOpacity(0),
        dropdownColor: kCardColor,
        isExpanded: true,
        isDense: true,
        autofocus: false,
        alignment: AlignmentDirectional.centerStart,
        items: myItems
            .map((e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  style: Responsive.isDesktop(context)
                      ? CustomTextStyle().textStyleDesktopkSecondrayColor
                      : CustomTextStyle().textStyleTabletkSecondrayColor,
                )))
            .toList(),
        onChanged: (value) {
          myController.text = value.toString();
          controller.setSelectedItem(nameDropDown, value.toString());
        },
        onSaved: (value) {},
        focusNode: FocusNode(),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
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
            //  borderRadius: BorderRadius.circular(15.0),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kErrorColor),
            //   borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
            //   borderRadius: BorderRadius.circular(15.0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kBlackColor),
            // borderRadius: BorderRadius.circular(15.0),
          ),
          errorStyle: Responsive.isDesktop(context)
              ? CustomTextStyle().textStyleDesktopKerrorColor
              : CustomTextStyle().textStyleTabletKerrorColor,
        ),
        validator: (value) {
          if (value.toString() == '') {
            return (errorTitle);
          }

          return null;
        });
  }
}
