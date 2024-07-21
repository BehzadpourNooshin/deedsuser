// import 'package:deedsuser/controllers/category_controller.dart';
// import 'package:deedsuser/controllers/filter_controller.dart';
// import 'package:deedsuser/controllers/showfilterformcontroller.dart';
// import 'package:deedsuser/theme/themes.dart';
// import 'package:deedsuser/utils/responsive.dart';
// import 'package:deedsuser/views/widgets/mychoicebox.dart';
// import 'package:deedsuser/views/widgets/mydropdownwidget.dart';
// import 'package:deedsuser/views/widgets/mymultichoiceboxwidget.dart';
// import 'package:deedsuser/views/widgets/myradiobutton.dart';
// import 'package:deedsuser/views/widgets/mytextfilterformfieldwidgetdigit.dart';
// import 'package:deedsuser/views/widgets/mytextfilterformfieldwidgetsecure.dart';
// import 'package:deedsuser/views/widgets/mytextfilterformfieldwidgetstring.dart';
// import 'package:deedsuser/views/widgets/mytextformfieldwidget.dart';
// import 'package:deedsuser/views/widgets/persiandatetimepicker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class FilterForm extends GetView<MyFilterFormController> {
//   const FilterForm({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     CategoryController categoryController = Get.put(CategoryController());
//     FilterController filterController = Get.put(FilterController());
//     final myController = TextEditingController();

//     return Scaffold(
//       body: Obx(
//         () => Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             if (categoryController.reportId.text != '')
//               Container(
//                 color: kPrimaryColor,
//                 child: Text(
//                   "گزارش ${categoryController.reportId.text.substring(0, categoryController.reportId.text.indexOf('-'))}",
//                   style: Responsive.isDesktop(context)
//                       ? CustomTextStyle().textStyleDesktopkBlackColorTitr
//                       : CustomTextStyle().textStyleTabletkBlackColorTitr,
//                 ),
//               ),
//             SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 child: filterController.filter.length > 0
//                     ? Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           for (var item in filterController.filter) ...[
//                             if ((item.formItemInputType == 'TextField' ||
//                                     item.formItemInputType == 'textfield') &&
//                                 (item.formItemType == 'int' ||
//                                     item.formItemType == 'Int')) ...[
//                               MyTextFormFilterFieldDigit(
//                                 labelTitle: item.formItemTitle,
//                                 hintTitle: item.formItemInputTypeHint,
//                               ),
//                               SizedBox(
//                                 height: Get.height / 30,
//                               ),
//                             ] else if ((item.formItemInputType == 'TextField' ||
//                                     item.formItemInputType == 'textfield') &&
//                                 ((item.formItemType == 'String' ||
//                                     item.formItemType == 'string'))) ...[
//                               MyTextFormFilterFieldString(
//                                 labelTitle: item.formItemTitle,
//                                 hintTitle: item.formItemInputTypeHint,
//                               ),
//                               SizedBox(
//                                 height: Get.height / 30,
//                               )
//                             ] else if ((item.formItemInputType == 'TextField' ||
//                                     item.formItemInputType == 'textfield') &&
//                                 ((item.formItemType == 'password' ||
//                                     item.formItemType == 'Password'))) ...[
//                               MyTextFormFilterFieldSecure(
//                                 labelTitle: item.formItemTitle,
//                                 hintTitle: item.formItemInputTypeHint,
//                               ),
//                               SizedBox(
//                                 height: Get.height / 30,
//                               )
//                             ] else if (item.formItemInputType == 'PickDate' ||
//                                 item.formItemInputType == 'pickdate') ...[
//                               StartEndWidget(),
//                               SizedBox(
//                                 height: Get.height / 30,
//                               )
//                             ] else if (item.formItemInputType == 'DropDown' ||
//                                 item.formItemInputType == 'dropdown') ...{
//                               MyFormBuilderDropdown(
//                                 labelTitle: item.formItemInputType,
//                                 nameDropDown: 'dropdown',
//                                 hintTitle: item.formItemInputTypeHint,
//                                 myController: TextEditingController(),
//                               ),
//                               SizedBox(
//                                 height: Get.height / 30,
//                               )
//                             } else if (item.formItemInputType ==
//                                     'Multichoicebox' ||
//                                 item.formItemInputType == 'multichoicebox') ...{
//                               MyFormBuilderFilterChip(
//                                 labelTitle: item.formItemInputType,
//                                 hintTitle: item.formItemInputTypeHint,
//                                 myController: TextEditingController(),
//                                 name: 'multichoicebox',
//                                 items: [],
//                               ),
//                               SizedBox(
//                                 height: Get.height / 30,
//                               )
//                             } else if (item.formItemInputType ==
//                                     'radiobutton' ||
//                                 item.formItemInputType == 'Radiobutton') ...{
//                               MyFormBuilderRadioGroup(
//                                 labelTitle: item.formItemInputType,
//                                 hintTitle: item.formItemInputTypeHint,
//                                 myController: TextEditingController(),
//                                 name: 'radiobutton',
//                                 items: [],
//                               ),
//                               SizedBox(
//                                 height: Get.height / 30,
//                               )
//                             } else if (item.formItemInputType == 'choicebox' ||
//                                 item.formItemInputType == 'Choicebox') ...{
//                               MyChoiceBox(
//                                 labelTitle: item.formItemInputType,
//                                 hintTitle: item.formItemInputTypeHint,
//                                 myController: TextEditingController(),
//                                 myItems: [],
//                                 nameCheckBox: 'choicebox',
//                               ),
//                               SizedBox(
//                                 height: Get.height / 30,
//                               )
//                             }
//                           ],
//                           ListView.builder(
//                             shrinkWrap: true,
//                             itemCount: controller.filterform.length,
//                             itemBuilder: (context, index) {
//                               return Row(
//                                 // children: [w(controller, index)],
//                                 mainAxisAlignment: MainAxisAlignment.end,

//                                 // onTap: () {
//                                 //   controller.selectedIndex.value = index;
//                                 //   controller.update();
//                                 //   Get.toNamed('/sampledata');
//                                 // },
//                               );
//                             },
//                           ),
//                           SizedBox(
//                             height: Get.height / 30,
//                           ),
//                         ],
//                       )
//                     : Column(children: [
//                         Row(children: [
//                           MyChoiceBox(
//                             labelTitle: 'فیلد1',
//                             nameCheckBox: 'chechbox',
//                             hintTitle: 'فیلد1',
//                             myController: myController,
//                             myItems: ['item1', 'item2', 'item3'],
//                           ),
//                           MyFormBuilderDropdown(
//                             labelTitle: 'فیلد2',
//                             nameDropDown: 'dropdown',
//                             hintTitle: 'فیلد2',
//                             myController: myController,
//                             myItems: ['item1', 'item2', 'item3'],
//                           ),
//                           MyFormBuilderFilterChip(
//                               myController: myController,
//                               labelTitle: 'فیلد3',
//                               name: 'mcheckbox',
//                               items: ['item1', 'item2', 'item3'],
//                               hintTitle: 'فیلد3'),
//                         ]),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Row(
//                           children: [
//                             MyFormBuilderRadioGroup(
//                                 myController: myController,
//                                 labelTitle: 'فیلد3',
//                                 name: 'mcheckbox',
//                                 items: ['item1', 'item2', 'item3'],
//                                 hintTitle: 'فیلد3'),
//                             MyTextFormField(
//                                 labelTitle: 'فیلد4',
//                                 hintTitle: 'فیلد4',
//                                 myicon: Icon(Icons.search),
//                                 myController: myController),
//                             MyTextFormField(
//                                 labelTitle: 'فیلد5',
//                                 hintTitle: 'فیلد5',
//                                 myicon: Icon(Icons.search),
//                                 secureText: true,
//                                 myController: myController)
//                           ],
//                         ),
//                         ElevatedButton(onPressed: () {}, child: Text('جستجو'))
//                       ])),
//           ],
//         ),
//       ),
//     );
//   }

//   // Widget w(controller, index) {
//   //   print(controller.filterform[index]['formItemType']);

//   //   final editcontroller = TextEditingController();
//   //   if (controller.filterform[index]['formItemInputType'] == 'TextFormField') {
//   //     /// any other task
//   //     return MyTextFormField(
//   //         errorTitle: '',
//   //         labelTitle: controller.filterform[index]['formItemTitle'],
//   //         hintTitle: controller.filterform[index]['formItemInputTypeHint'],
//   //         myController: editcontroller);
//   //   } else if (controller.filterform[index]['formItemInputType'] ==
//   //       'DropDown') {
//   //     /// any other task
//   //     return MyFormBuilderDropdown(
//   //       errorTitle: '',
//   //       labelTitle: controller.filterform[index]['formItemTitle'],
//   //       hintTitle: controller.filterform[index]['formItemInputTypeHint'],
//   //       myController: editcontroller,
//   //       nameDropDown: 'dropdown',
//   //       myItems: [],
//   //     );
//   //   }
//   //   return Text('');
//   // }
// }
