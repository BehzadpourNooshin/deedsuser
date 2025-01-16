import 'dart:math';
import 'package:deedsuser/controllers/datatime_controller.dart';
import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:deedsuser/views/widgets/persiannumbertext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class MyMultiTypeTextFormFilterFieldDateTimeESBDateTime
    extends StatelessWidget {
  final String labelTitle;
  final String hintTitle;
  final String errorTitle;
  final String validation;
  final String name;
  final TextEditingController dateTimeController;
  final bool secureText;

  const MyMultiTypeTextFormFilterFieldDateTimeESBDateTime({
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
          firstDate: (finalName.contains('from') ||
                      finalName.contains('begin') ||
                      finalName.contains('start')) &&
                  _dateTimeController.selectedEndDate.value != 'تاریخ پایان'
              ? _dateTimeController.selectedTempEndDate.addDays(-30)
              : Jalali(1400),
          lastDate: (finalName.contains('to') || finalName.contains('end')) &&
                  _dateTimeController.selectedStartDate.value != 'تاریخ شروع'
              ? _dateTimeController.selectedTempStartDate.addDays(30)
              : Jalali(1499),
          helpText: 'انتخاب تاریخ',
          cancelText: 'لغو',
          confirmText: 'تایید',
          builder: (context, child) {
            return Theme(
                data: ThemeData(
                  primaryColor: kPrimaryColor,
                  dialogTheme: DialogTheme(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: kPrimaryColor, // رنگ متن دکمه
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                child: child!);
          },
        );
        if (pickedDate != null) {
          TimeOfDay? pickedTime = await showPersianTimePicker(
            context: context,
            initialTime: const TimeOfDay(hour: 0, minute: 0),
            helpText: 'انتخاب زمان',
            cancelText: 'لغو',
            confirmText: 'تایید',
            builder: (context, child) {
              return Theme(
                data: ThemeData(
                  primaryColor: kPrimaryColor,
                  dialogTheme: DialogTheme(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  timePickerTheme: TimePickerThemeData(
                    dialBackgroundColor: Colors.deepPurple.shade50,
                    dialHandColor: kPrimaryColor,
                    hourMinuteColor: Colors.deepPurple.shade100,
                    hourMinuteTextColor: Colors.white,
                    dayPeriodTextColor: Colors.white,
                    dayPeriodColor: kDarktBlueColor,
                  ),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: kPrimaryColor, // رنگ متن دکمه
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                child: child!,
              );
            },
          );

          if (pickedTime != null) {
            DateTime dateTime = pickedDate.toDateTime().add(
                Duration(hours: pickedTime.hour, minutes: pickedTime.minute));

            String selectedDateTimeShamsi =
                '${pickedDate.year.toString()}${pickedDate.month.toString().padLeft(2, '0')}${pickedDate.day.toString().padLeft(2, '0')}T${pickedTime.hour.toString().padLeft(2, '0')}${pickedTime.minute.toString().padLeft(2, '0')}00';

            if (finalName.contains('from') ||
                finalName.contains('begin') ||
                finalName.contains('start')) {
              _dateTimeController.selectedTempStartDate = pickedDate;
              _dateTimeController.selectedStartDate.value =
                  selectedDateTimeShamsi.toString();
            } else if (finalName.contains('to') || finalName.contains('end')) {
              _dateTimeController.selectedEndDate.value =
                  selectedDateTimeShamsi.toString();
              _dateTimeController.selectedTempEndDate = pickedDate;
            } else {
              _dateTimeController.selectedSingleDate.value =
                  selectedDateTimeShamsi.toString();
            }

            dateTimeController.text = selectedDateTimeShamsi.toString();
            _dateTimeController.update();
          }
        }
      },
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                      min(
                          _dateTimeController.selectedStartDate
                              .toString()
                              .length,
                          19))
                  : (finalName.contains('to') || finalName.contains('end'))
                      ? _dateTimeController.selectedEndDate
                          .toString()
                          .substring(
                              0,
                              min(
                                  _dateTimeController.selectedEndDate
                                      .toString()
                                      .length,
                                  19))
                      : _dateTimeController.selectedSingleDate
                          .toString()
                          .substring(
                              0,
                              min(
                                  _dateTimeController.selectedSingleDate
                                      .toString()
                                      .length,
                                  19)),
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
              icon: Icon(Icons.clear, size: SideMenuConstant().iconSize),
            ),
          ],
        ),
      ),
    );
  }
}
