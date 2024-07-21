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
                        .contains('perisan')
                ? validation.contains('/')
                    ? '${pickedDate.year.toString()}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.day.toString().padLeft(2, '0')}'
                    : validation.contains('-')
                        ? '${pickedDate.year.toString()}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}'
                        : '${pickedDate.year.toString()}${pickedDate.month.toString().padLeft(2, '0')}${pickedDate.day.toString().padLeft(2, '0')}'
                : validation.contains('میلادی') ||
                        !validation
                            .toLowerCase()
                            .replaceAll(' ', '')
                            .contains('perisan')
                    ? validation.contains('/')
                        ? '${georgeianPickedData?.year.toString()}/${georgeianPickedData?.month.toString().padLeft(2, '0')}/${georgeianPickedData?.day.toString().padLeft(2, '0')}'
                        : validation.contains('-')
                            ? '${georgeianPickedData?.year.toString()}-${georgeianPickedData?.month.toString().padLeft(2, '0')}-${georgeianPickedData?.day.toString().padLeft(2, '0')}'
                            : '${georgeianPickedData?.year.toString()}${georgeianPickedData?.month.toString().padLeft(2, '0')}${georgeianPickedData?.day.toString().padLeft(2, '0')}'
                    : pickedDate.toDateTime().toIso8601String();

            (labelTitle.contains('از')
                ? _dateTimeController.selectedStartDate.value = selectedDate
                : _dateTimeController.selectedEndDate.value = selectedDate);
            dateTimeController.text = selectedDate;
            _dateTimeController.update();
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
                    top: kDefaultPadding / 4,
                    bottom: kDefaultPadding / 4), // add padding to adjust icon
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
                  : CustomTextStyle()
                      .textStyleTabletKerrorColor, // add padding to adjust icon
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return (errorTitle);
              }

              return null;
            })));

    // Row(mainAxisAlignment: MainAxisAlignment.start, children: [
    //   Icon(
    //     Icons.calendar_month,
    //     size: SideMenuConstant().iconSize,
    //     color: kBlackColor,
    //   ),
    //   Row(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     children: [
    //       Text(
    //         (labelTitle.contains('از'))
    //             ? _dateTimeController.selectedStartDate
    //                 .toString()
    //                 .substring(
    //                     0,
    //                     min(
    //                         _dateTimeController.selectedStartDate
    //                             .toString()
    //                             .length,
    //                         13))
    //             : _dateTimeController.selectedEndDate.toString().substring(
    //                 0,
    //                 min(
    //                     _dateTimeController.selectedEndDate
    //                         .toString()
    //                         .length,
    //                     13)),
    //         style: Responsive.isDesktop(context)
    //             ? CustomTextStyle().textStyleDesktopkSecondrayColor
    //             : CustomTextStyle().textStyleTabletkSecondrayColor,
    //       ),
    //       IconButton(
    //           onPressed: () {
    //             dateTimeController.text = '';
    //             (labelTitle.contains('از'))
    //                 ? _dateTimeController.selectedStartDate.value =
    //                     'تاریخ شروع'
    //                 : _dateTimeController.selectedEndDate.value =
    //                     'تاریخ پایان';

    //             _dateTimeController.update();
    //           },
    //           icon: Icon(Icons.clear, size: SideMenuConstant().iconSize))
    //     ],
    //   ),
    // ]),
    //   ),
    // );
  }
}
