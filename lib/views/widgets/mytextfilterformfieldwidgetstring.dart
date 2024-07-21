import 'package:deedsuser/utils/constant.dart';

import 'package:deedsuser/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormFilterFieldString extends StatelessWidget {
  final String labelTitle;
  final String hintTitle;
  final String errorTitle;

  final bool secureText;
  const MyTextFormFilterFieldString({
    super.key,
    required this.labelTitle,
    required this.hintTitle,
    this.errorTitle = "",
    this.secureText = false,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: Responsive.isDesktop(context)
            ? CustomTextStyle().textStyleDesktopkSecondrayColor
            : CustomTextStyle().textStyleTabletkSecondrayColor,
        onChanged: (value) {},
        onSaved: (value) {},
        focusNode: FocusNode(),
        autofocus: false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: secureText,
        textAlign: TextAlign.end,
        keyboardType: TextInputType.name,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.singleLineFormatter,
        ],
        decoration: InputDecoration(
          floatingLabelAlignment: FloatingLabelAlignment.center,
          alignLabelWithHint: true,
          border: OutlineInputBorder(),
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
          if (value!.isEmpty) {
            return (errorTitle);
          }

          return null;
        });
  }
}
