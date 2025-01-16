import 'dart:math';

import 'package:deedsuser/controllers/datatime_controller.dart';
import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:deedsuser/views/widgets/persiannumbertext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class MyMultiTypeTextFormFilterFieldDateTimeTimeSTamp extends StatelessWidget {
  final String labelTitle;
  final String hintTitle;
  final String errorTitle;
  final String validation;
  final String name;
  final TextEditingController dateTimeController;
  final bool secureText;

  const MyMultiTypeTextFormFilterFieldDateTimeTimeSTamp({
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
        Jalali? pickedDate = await showPersianDatePicker(
          context: context,
          initialDate: Jalali.now(),
          firstDate: Jalali(1400),
          lastDate: Jalali(1499),
        );

        if (pickedDate != null) {
          TimeOfDay? pickedTime = await showPersianTimePicker(
            context: context,
            initialTime: const TimeOfDay(hour: 0, minute: 0), // ساعت 00:00
          );

          if (pickedTime != null) {
            DateTime dateTime = pickedDate.toDateTime().add(
                Duration(hours: pickedTime.hour, minutes: pickedTime.minute));

            String selectedDate = validation.contains('شمسی') ||
                    validation
                        .toLowerCase()
                        .replaceAll(' ', '')
                        .contains('persian')
                ? '${pickedDate.year.toString()}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.day.toString().padLeft(2, '0')} ${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}'
                : dateTime.toIso8601String();

            String selectedDateTimeShamsi =
                '${pickedDate.year.toString()}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')} ${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';

            int timestamp = (dateTime.millisecondsSinceEpoch / 1000).round();

            if (finalName.contains('from') ||
                finalName.contains('begin') ||
                finalName.replaceAll(' ', '').contains('start')) {
              _dateTimeController.selectedStartDate.value =
                  timestamp.toString();
              _dateTimeController.startDateTimestamp.value = timestamp;
            } else if (finalName.contains('to') || finalName.contains('end')) {
              _dateTimeController.selectedEndDate.value = timestamp.toString();
              _dateTimeController.endDateTimestamp.value = timestamp;
            } else {
              _dateTimeController.selectedSingleDate.value =
                  timestamp.toString();
              _dateTimeController.singleDateTimestamp.value = timestamp;
            }

            dateTimeController.text = timestamp.toString();

            _dateTimeController.update();
          }
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
                        19)) // تاریخ و زمان
                : (finalName.contains('to') || finalName.contains('end'))
                    ? _dateTimeController.selectedEndDate.toString().substring(
                        0,
                        min(
                            _dateTimeController.selectedEndDate
                                .toString()
                                .length,
                            19)) // تاریخ و زمان
                    : _dateTimeController.selectedSingleDate
                        .toString()
                        .substring(
                            0,
                            min(
                                _dateTimeController.selectedSingleDate
                                    .toString()
                                    .length,
                                19)), // تاریخ و زمان
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
