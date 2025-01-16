import 'package:deedsuser/controllers/datatime_controller.dart';
import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class MyTextFormFilterFieldDateTime extends StatelessWidget {
  final String labelTitle;
  final String hintTitle;
  final String errorTitle;
  final String validation;
  final TextEditingController dateTimeController;
  final bool secureText;

  const MyTextFormFilterFieldDateTime({
    super.key,
    required this.labelTitle,
    required this.hintTitle,
    required this.validation,
    this.errorTitle = "",
    this.secureText = false,
    required this.dateTimeController,
  });

  @override
  Widget build(BuildContext context) {
    dateTimeController.text = labelTitle;

    DateTimeController _dateTimeController = Get.put(DateTimeController());
    return TextButton(
        iconAlignment: IconAlignment.start,
        style: Styles().dateTimeStyleButton,
        focusNode: FocusNode(),
        autofocus: false,
        onPressed: () async {
          Jalali? pickedDate = await showPersianDatePicker(
            context: context,
            initialDate: Jalali.now(),
            firstDate: (labelTitle.contains('از')) &&
                    _dateTimeController.selectedEndDate.value != 'تاریخ پایان'
                ? _dateTimeController.selectedTempEndDate.addDays(-30)
                : Jalali(1400),
            lastDate: (labelTitle.contains(' تا')) &&
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
              initialTime: TimeOfDay.now(),
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
              String selectedDateTime = validation.contains('شمسی') ||
                      validation
                          .toLowerCase()
                          .replaceAll(' ', '')
                          .contains('persian')
                  ? validation.contains('/')
                      ? '${pickedDate.year.toString()}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.day.toString().padLeft(2, '0')} ${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}'
                      : validation.contains('-')
                          ? '${pickedDate.year.toString()}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')} ${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}'
                          : '${pickedDate.year.toString()}${pickedDate.month.toString().padLeft(2, '0')}${pickedDate.day.toString().padLeft(2, '0')} ${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}'
                  : validation.contains('میلادی') ||
                          !validation
                              .toLowerCase()
                              .replaceAll(' ', '')
                              .contains('persian')
                      ? validation.contains('/')
                          ? '${dateTime.year.toString()}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.day.toString().padLeft(2, '0')} ${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}'
                          : validation.contains('-')
                              ? '${dateTime.year.toString()}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}'
                              : '${dateTime.year.toString()}${dateTime.month.toString().padLeft(2, '0')}${dateTime.day.toString().padLeft(2, '0')} ${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}'
                      : dateTime.toIso8601String();

              (
                labelTitle.contains('از')
                    ? {
                        _dateTimeController.selectedStartDate.value =
                            selectedDateTime,
                        _dateTimeController.selectedTempStartDate = pickedDate,
                      }
                    : {
                        _dateTimeController.selectedEndDate.value =
                            selectedDateTime,
                        _dateTimeController.selectedTempEndDate = pickedDate
                      },
                dateTimeController.text = selectedDateTime
              );
              _dateTimeController.update();
            }
          }
        },
        child: Obx(() => TextFormField(
            style: Responsive.isDesktop(context)
                ? CustomTextStyle().textStyleDesktopkSecondrayColor
                : CustomTextStyle().textStyleTabletkSecondrayColor,
            minLines: 1,
            onSaved: (value) {},
            focusNode: FocusNode(),
            autofocus: false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlign: TextAlign.right,
            enabled: false,
            textDirection: TextDirection.ltr,
            decoration: InputDecoration(
              labelText: labelTitle,
              prefixIcon: Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child: Icon(
                  Icons.calendar_month,
                  size: SideMenuConstant().iconSize,
                  color: kBlackColor,
                ),
              ),
              suffixIcon: Padding(
                padding: EdgeInsets.only(
                    top: kDefaultPadding / 4, bottom: kDefaultPadding / 4),
                child: IconButton(
                  icon: const Icon(
                    size: 20,
                    Icons.clear,
                    color: kBlackColor,
                  ),
                  onPressed: () {
                    dateTimeController.text = '';
                    (labelTitle.contains('از'))
                        ? _dateTimeController.selectedStartDate.value =
                            'تاریخ شروع'
                        : _dateTimeController.selectedEndDate.value =
                            'تاریخ پایان';

                    _dateTimeController.update();
                  },
                ),
              ),
              floatingLabelAlignment: FloatingLabelAlignment.center,
              alignLabelWithHint: true,
              border: const OutlineInputBorder(),
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
            validator: (value) {
              if (value!.isEmpty) {
                return errorTitle;
              }
              return null;
            })));
  }
}
