// import 'dart:convert';
// import 'dart:io';

// import 'package:deedsuser/controllers/accounts_controller.dart';
// import 'package:deedsuser/controllers/category_controller.dart';
// import 'package:deedsuser/controllers/columns_controller.dart';
// import 'package:deedsuser/controllers/filter_controller.dart';
// import 'package:deedsuser/controllers/table_controller.dart';
// import 'package:deedsuser/models/accounts_model.dart';
// import 'package:deedsuser/controllers/textediting_controller.dart';
// import 'package:deedsuser/models/categoryandreport_model.dart';
// import 'package:deedsuser/theme/themes.dart';
// import 'package:deedsuser/utils/constant.dart';
// import 'package:deedsuser/utils/responsive.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:deedsuser/controllers/categoryandreport_controller.dart';

// class FavoriteReportTable extends StatelessWidget {
//   FavoriteReportTable({
//     super.key,
//   });

//   final searchVal = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     CategoryandReportController categoryandReportController =
//         Get.put(CategoryandReportController());
//     // initialAccountFiltered(reportController);
//     return Container(
//       padding: EdgeInsets.all(kDefaultPadding),
//       decoration: const BoxDecoration(
//         color: kScreenBackgroundColor,
//         borderRadius: BorderRadius.all(Radius.circular(10)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Padding(
//             padding: EdgeInsets.all(kDefaultPadding),
//             child: MySearchAppBar(),
//           ),
//           Scrollbar(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.only(
//                     right: kDefaultPadding / 2, left: kDefaultPadding / 2),
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: Expanded(
//                     child: DataTable(
//                       headingRowColor: MaterialStateColor.resolveWith(
//                           (states) => kCardColor),

//                       // minWidth: 600,
//                       columns: [
//                         DataColumn(
//                           label: Expanded(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   "افزودن به علاقه مندی",
//                                   textAlign: TextAlign.center,
//                                   style: Responsive.isDesktop(context)
//                                       ? CustomTextStyle()
//                                           .textStyleDesktopKprimaryColorTitr
//                                       : CustomTextStyle()
//                                           .textStyleDesktopKprimaryColorTitr,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         DataColumn(
//                           label: Expanded(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   textAlign: TextAlign.right,
//                                   "گروه",
//                                   style: Responsive.isDesktop(context)
//                                       ? CustomTextStyle()
//                                           .textStyleDesktopKprimaryColorTitr
//                                       : CustomTextStyle()
//                                           .textStyleDesktopKprimaryColorTitr,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         DataColumn(
//                           label: Expanded(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   textAlign: TextAlign.right,
//                                   "گزارش",
//                                   style: Responsive.isDesktop(context)
//                                       ? CustomTextStyle()
//                                           .textStyleDesktopKprimaryColorTitr
//                                       : CustomTextStyle()
//                                           .textStyleDesktopKprimaryColorTitr,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                       rows: categoryandReportController
//                               .categoryandreports.isNotEmpty
//                           ? myDataRow(context)
//                           : [],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   List<DataRow> myDataRow(BuildContext context) {
//     CategoryandReportController categoryAndReportController =
//         Get.put(CategoryandReportController());
//     return List.generate(
//       categoryAndReportController.categoryandreports.length,
//       (index) => DataRow(
//         cells: [
//           DataCell(Expanded(
//               child:
//                   Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//             IconButton(
//               icon: const Icon(
//                 Icons.favorite,
//                 color: kCyanColor,
//               ),
//               iconSize: 35,
//               onPressed: () {
//                 //callapi
//               },
//             ),
//           ]))),
//           DataCell(Expanded(
//               child:
//                   Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Text(
//               categoryAndReportController.categoryandreports[index].reportName,
//               style: Responsive.isDesktop(context)
//                   ? CustomTextStyle().textStyleDesktopKprimaryColorTitr
//                   : CustomTextStyle().textStyleDesktopKprimaryColorTitr,
//             ),
//           ]))),
//           DataCell(Expanded(
//               child:
//                   Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Text(
//               categoryAndReportController
//                   .categoryandreports[index].categoryName,
//               style: Responsive.isDesktop(context)
//                   ? CustomTextStyle().textStyleDesktopKprimaryColorTitr
//                   : CustomTextStyle().textStyleDesktopKprimaryColorTitr,
//             ),
//           ]))),
//         ],
//       ),
//     );
//   }
// }

// class MySearchAppBar extends GetView<CategoryandReportController> {
//   const MySearchAppBar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final themeData = Theme.of(context);
//     CategoryandReportController categoryAndReportController =
//         Get.put(CategoryandReportController());
//     return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//       Container(
//           decoration: BoxDecoration(
//             color: kCardColor,
//             border: Border.all(
//               width: 1,
//             ),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           width: Get.width / 6,
//           height: Get.height / 13,
//           child: ListTile(
//             leading: IconButton(
//               icon: Icon(Icons.cancel),
//               onPressed: () {
//                 initialCategoryAndReportShowAndFiltered(
//                     categoryAndReportController);
//               },
//             ),
//             title: TextField(
//                 // controller: searchVal,
//                 decoration: InputDecoration(
//                     hintText: 'جستجو', border: InputBorder.none),
//                 onChanged: (String? searchValue) {
//                   // controller.accountsFiltered.clear();
//                   // controller.update();
//                   // controller.countOfAccountsFiltered.value = 0;
//                   print(searchValue);

//                   categoryAndReportController.searchOfCategoryAndReport.value =
//                       searchValue!;
//                   categoryAndReportController.update();
//                   initialCategoryAndReportShow(categoryAndReportController);

//                   print("search");
//                   //
//                   print(categoryAndReportController
//                       .searchOfCategoryAndReport.value);
//                   print(categoryAndReportController
//                       .categoryAndReportsShow.length);
//                   print(categoryAndReportController
//                       .categoryAndReportFiltered.length);
//                   for (var categoryandreport
//                       in categoryAndReportController.categoryAndReportsShow) {
//                     if (categoryandreport.categoryName.contains(
//                                 categoryAndReportController
//                                     .searchOfCategoryAndReport.value) ==
//                             true ||
//                         categoryandreport.reportName.contains(
//                                 categoryAndReportController
//                                     .searchOfCategoryAndReport.value) ==
//                             true) {
//                       print(categoryandreport.categoryName);
//                       // if (!controller.accountsFiltered.any((accountFiltered) =>
//                       //     accountFiltered.email == account.email)) {
//                       print(categoryandreport.reportName);

//                       categoryAndReportController.categoryAndReportFiltered.add(
//                         CategoryAndReportModel(
//                           categoryName: categoryandreport.categoryName,
//                           reportName: categoryandreport.reportName,
//                           displayName: categoryandreport.displayName,
//                         ),
//                       );
//                       categoryAndReportController
//                           .updateCountOfCategoryAndReportFiltered();
//                       categoryAndReportController.update();
//                     }
//                   }
//                   // }
//                   categoryAndReportController.update();
//                   // controller.accountsShow = controller.accountsFiltered;
//                   // controller.update();
//                 }),
//             trailing: IconButton(
//               icon: Icon(Icons.search),
//               onPressed: () {
//                 initialCategoryAndReportShow(categoryAndReportController);

//                 print("search");
//                 //

//                 for (var categoryandreport
//                     in categoryAndReportController.categoryAndReportsShow) {
//                   if (categoryandreport.categoryName.contains(
//                               categoryAndReportController
//                                   .searchOfCategoryAndReport.value) ==
//                           true ||
//                       categoryandreport.reportName.contains(
//                               categoryAndReportController
//                                   .searchOfCategoryAndReport.value) ==
//                           true) {
//                     categoryAndReportController.categoryAndReportFiltered.add(
//                       CategoryAndReportModel(
//                         categoryName: categoryandreport.categoryName,
//                         reportName: categoryandreport.reportName,
//                         displayName: categoryandreport.displayName,
//                       ),
//                     );
//                     categoryAndReportController
//                         .countOfCategoryAndReportFiltered();
//                     categoryAndReportController.update();
//                   }
//                 }
//                 // }
//                 categoryAndReportController.update();
//               },
//             ),
//           ))
//     ]);
//   }
// }

// initialCategoryAndReportShow(
//     CategoryandReportController categoryAndReportController) {
//   categoryAndReportController.categoryAndReportSelected.clear();
//   categoryAndReportController.categoryAndReportFiltered.clear();
//   categoryAndReportController.countOfCategoryAndReportFiltered.value = 0;
//   for (var categoryAndReport
//       in categoryAndReportController.categoryandreports) {
//     Get.find<CategoryandReportController>().categoryAndReportFiltered.add(
//           CategoryAndReportModel(
//             categoryName: categoryAndReport.categoryName,
//             reportName: categoryAndReport.reportName,
//             displayName: categoryAndReport.displayName,
//           ),
//         );
//     categoryAndReportController.update();
//     // accountsController.accountsFiltered = accountsController.accountsShow;
//     // accountsController.update();
//   }
//   categoryAndReportController.updateCountOfCategoryAndReportFiltered();
//   categoryAndReportController.update();
// }

// initialCategoryAndReportShowAndFiltered(
//     CategoryandReportController categoryAndReportController) {
//   categoryAndReportController.categoryAndReportSelected.clear();
//   categoryAndReportController.categoryAndReportsShow.clear();
//   categoryAndReportController.countOfCategoryAndReportsShow.value = 0;
//   for (var categoryAndReport
//       in categoryAndReportController.categoryandreports) {
//     Get.find<CategoryandReportController>().categoryAndReportsShow.add(
//           CategoryAndReportModel(
//             categoryName: categoryAndReport.categoryName,
//             reportName: categoryAndReport.reportName,
//             displayName: categoryAndReport.displayName,
//           ),
//         );
//     categoryAndReportController.update();
//     // accountsController.accountsFiltered = accountsController.accountsShow;
//     // accountsController.update();
//   }
//   categoryAndReportController.updateCountOfCategoryAndReportsShow();

//   categoryAndReportController.categoryAndReportFiltered =
//       categoryAndReportController.categoryAndReportsShow;
//   categoryAndReportController.update();
// }

// initialCategoryAndReportsShowShow(
//     CategoryandReportController categoryAndReportController) {
//   categoryAndReportController.categoryAndReportSelected.clear();
//   categoryAndReportController.categoryAndReportsShow.clear();
//   //categoryAndReportController.countOfCategoryAndReportSelected.value = 0;
//   categoryAndReportController.categoryAndReportFiltered.clear();
//   categoryAndReportController.countOfCategoryAndReportFiltered.value = 0;
//   for (var categoryAndReport
//       in categoryAndReportController.categoryandreports) {
//     Get.find<CategoryandReportController>().categoryAndReportsShow.add(
//           CategoryAndReportModel(
//             categoryName: categoryAndReport.categoryName,
//             reportName: categoryAndReport.reportName,
//             displayName: categoryAndReport.displayName, reports: [],
//           ),
//         );
//     categoryAndReportController.update();
//     // accountsController.accountsFiltered = accountsController.accountsShow;
//     // accountsController.update();
//   }
//   categoryAndReportController.updateCountOfCategoryAndReportsShow();
//   categoryAndReportController.update();
// }
