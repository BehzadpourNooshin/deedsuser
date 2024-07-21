import 'dart:math';

import 'package:deedsuser/controllers/datatime_controller.dart';
import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class MyMultiTypeTextFormFilterFieldDateTime extends StatelessWidget {
  final String labelTitle;
  final String hintTitle;
  final String errorTitle;
  final String validation;
  final String name;
  final TextEditingController dateTimeController;
  final bool secureText;

  const MyMultiTypeTextFormFilterFieldDateTime({
    super.key,
    required this.labelTitle,
    required this.hintTitle,
    required this.validation,
    required this.name,
    this.errorTitle = "",
    this.secureText = false,
    required this.dateTimeController,
  });

  @override
  Widget build(BuildContext context) {
    dateTimeController.text = labelTitle;
    String finalName = name.toLowerCase().replaceAll(' ', '');
    DateTimeController _dateTimeController = Get.put(DateTimeController());
    return TextButton(
      style: Styles().dateTimeStyleButton,
      focusNode: FocusNode(),
      autofocus: false,
      onPressed: () async {
        //DateTimeController _dateTimeController = Get.put(DateTimeController());
        Jalali? pickedDate = await showPersianDatePicker(
          context: context,
          initialDate: Jalali.now(),
          firstDate: Jalali(1400),
          lastDate: Jalali(1499),
        );
        var georgeianPickedData = pickedDate?.toGregorian();
        if (pickedDate != null) {
          String selectedDate = validation.contains('شمسی') ||
                  validation
                      .toLowerCase()
                      .replaceAll(' ', '')
                      .contains('persian')
              ? validation.contains('/')
                  ? '${pickedDate.year.toString()}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.day.toString().padLeft(2, '0')}'
                  : validation.contains('-')
                      ? '${pickedDate.year.toString()}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}'
                      : '${pickedDate.year.toString()}${pickedDate.month.toString().padLeft(2, '0')}${pickedDate.day.toString().padLeft(2, '0')}'
              : validation.contains('میلادی') ||
                      !validation
                          .toLowerCase()
                          .replaceAll(' ', '')
                          .contains('persian')
                  ? validation.contains('/')
                      ? '${georgeianPickedData?.year.toString()}/${georgeianPickedData?.month.toString().padLeft(2, '0')}/${georgeianPickedData?.day.toString().padLeft(2, '0')}'
                      : validation.contains('-')
                          ? '${georgeianPickedData?.year.toString()}-${georgeianPickedData?.month.toString().padLeft(2, '0')}-${georgeianPickedData?.day.toString().padLeft(2, '0')}'
                          : '${georgeianPickedData?.year.toString()}${georgeianPickedData?.month.toString().padLeft(2, '0')}${georgeianPickedData?.day.toString().padLeft(2, '0')}'
                  : pickedDate.toDateTime().toIso8601String();

          (finalName.contains('from') ||
                  finalName.contains('begin') ||
                  finalName.replaceAll(' ', '').contains('start'))
              ? _dateTimeController.selectedStartDate.value = selectedDate
              : (finalName.contains('to') || finalName.contains('end'))
                  ? _dateTimeController.selectedEndDate.value = selectedDate
                  : _dateTimeController.selectedSingleDate.value = selectedDate;
          dateTimeController.text = selectedDate;
          _dateTimeController.update();
        }
      },
      child: Obx(
        () => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Icon(
            Icons.calendar_month,
            size: SideMenuConstant().iconSize,
            color: kBlackColor,
          ),
          Text(
            (finalName.contains('from') ||
                    finalName.contains('begin') ||
                    finalName.contains('start'))
                ? _dateTimeController.selectedStartDate.toString().substring(
                    0,
                    min(_dateTimeController.selectedStartDate.toString().length,
                        13))
                : (finalName.contains('to') || finalName.contains('end'))
                    ? _dateTimeController.selectedEndDate.toString().substring(
                        0,
                        min(
                            _dateTimeController.selectedEndDate
                                .toString()
                                .length,
                            13))
                    : _dateTimeController.selectedSingleDate
                        .toString()
                        .substring(
                            0,
                            min(
                                _dateTimeController.selectedSingleDate
                                    .toString()
                                    .length,
                                13)),
            style: Responsive.isDesktop(context)
                ? CustomTextStyle().textStyleDesktopkSecondrayColor
                : CustomTextStyle().textStyleTabletkSecondrayColor,
          ),
          IconButton(
              onPressed: () {
                dateTimeController.text = '';
                finalName.contains('from') ||
                        finalName.contains('begin') ||
                        finalName.contains('start')
                    ? _dateTimeController.selectedStartDate.value = 'تاریخ شروع'
                    : finalName.contains('to') || finalName.contains('end')
                        ? _dateTimeController.selectedEndDate.value =
                            'تاریخ پایان'
                        : _dateTimeController.selectedSingleDate.value =
                            'تاریخ';
                _dateTimeController.update();
              },
              icon: Icon(Icons.clear, size: SideMenuConstant().iconSize))
        ]),
      ),
    );
  }
}
