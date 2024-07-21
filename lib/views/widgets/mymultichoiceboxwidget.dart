import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MyFormBuilderFilterChip extends StatelessWidget {
  const MyFormBuilderFilterChip({
    super.key,
    required this.myController,
    required this.labelTitle,
    required this.name,
    required this.items,
    required this.hintTitle,
  });

  final List items;
  final TextEditingController myController;
  final String labelTitle;
  final String name;
  final String hintTitle;

  @override
  Widget build(BuildContext context) {
    return FormBuilderFilterChip(
      onChanged: (value) {
        if (value!.isNotEmpty) {
          myController.text = value.toString();
        }
      },
      direction: Axis.horizontal,
      name: name,
      spacing: kDefaultPadding,
      runSpacing: kDefaultPadding,
      selectedColor: kCyanColor,
      checkmarkColor: kBlackColor,
      backgroundColor: kLightGreyColor,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(kDefaultPadding),
        labelStyle: Responsive.isDesktop(context)
            ? CustomTextStyle().textStyleDesktopkSecondrayColor
            : CustomTextStyle().textStyleTabletkSecondrayColor,
        floatingLabelAlignment: FloatingLabelAlignment.center,
        alignLabelWithHint: true,
        labelText: labelTitle,
        border: const OutlineInputBorder(),
      ),
      options: [
        for (var item in items)
          FormBuilderChipOption(
              value: item,
              child: Text(
                item,
                style: Responsive.isDesktop(context)
                    ? CustomTextStyle().textStyleDesktopkSecondrayColor
                    : CustomTextStyle().textStyleTabletkSecondrayColor,
              )),
      ],
    );
  }
}
