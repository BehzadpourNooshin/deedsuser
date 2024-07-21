import 'package:deedsuser/controllers/dropdown_controller.dart';
import 'package:deedsuser/controllers/full_report_controller.dart';
import 'package:deedsuser/controllers/json_controller.dart';
import 'package:deedsuser/controllers/menu_controller.dart';
import 'package:deedsuser/controllers/resultsearch_controller.dart';
import 'package:deedsuser/controllers/search_controller.dart';
import 'package:deedsuser/functions/makesearch.dart';
import 'package:deedsuser/functions/makesearchapi.dart';
import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:deedsuser/views/widgets/mychoicebox.dart';
import 'package:deedsuser/views/widgets/mymultichoiceboxwidget.dart';
import 'package:deedsuser/views/widgets/mysearchabledropdown.dart';
import 'package:deedsuser/views/widgets/mytextformfielddatetimewidget.dart';
import 'package:deedsuser/views/widgets/mytextformfielddatetimewidgetmulti.dart';
import 'package:deedsuser/views/widgets/mytextformfieldwidgetsidemenu.dart';
import 'package:deedsuser/views/widgets/mytextformfieldwidgetsidemenudigit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EndSideMenu extends StatelessWidget {
  const EndSideMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final SideMenusController sideMenusController =
        Get.put(SideMenusController());
    FullReportController fullReportController = Get.put(FullReportController());
    ResultSearchController resultSearchController =
        Get.put(ResultSearchController());
    DropdownController dropdownController = Get.put(DropdownController());
    OptionSearchController optionSearchController =
        Get.put(OptionSearchController());
    JsonController jsonController = Get.put(JsonController());
    return Obx(() => Responsive.isDesktop(context) &&
            !sideMenusController.isDrawerOpen.value
        ? Drawer(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(0),
              ),
            ),
            // shape: ShapeBorder.lerp(null, null, 0),
            backgroundColor: kCardColor.withOpacity(0),
            child: ListView(

                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    title: Icon(
                      Icons.arrow_back,
                      size: SideMenuConstant().iconSize,
                      color: kPrimaryColor,
                    ),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      sideMenusController.toggleDrawer();
                    },
                  ),
                  if (fullReportController.selectedreport.isEmpty)
                    Container()
                  else ...[
                    ListTile(
                      title: SizedBox(
                        width: ResponsiveSizedBox().middleSizeBoxWidth,
                        height: ResponsiveSizedBox().middleSizeBoxHeight,
                        child: ElevatedButton(
                          style: Styles().mainStyleButton,
                          onPressed: () {
                            resultSearchController.headers.clear();
                            jsonController.jsonText.value = '';
                            jsonController.update();
                            resultSearchController.datarows.clear();
                            resultSearchController.headerForProperties.clear();
                            resultSearchController.datarowsForProperties
                                .clear();
                            resultSearchController.datarows.clear();
                            resultSearchController.result.clear();
                            resultSearchController.columnchartdatasource
                                .clear();
                            resultSearchController.piechartdatasource.clear();
                            resultSearchController.linechartdatasource.clear();
                            resultSearchController.piechartdatasource.clear();
                            resultSearchController.linechartdatasource.clear();
                            resultSearchController.update();
                            optionSearchController.searchs.clear();
                            optionSearchController.searcDetailhForProperties
                                .clear();
                            optionSearchController.searchDetail.clear();
                            optionSearchController.searchForProperties.clear();
                            optionSearchController.searchapi.clear();
                            optionSearchController.update();
                            if (fullReportController
                                    .selectedreport[0].report.scope ==
                                'FilterForm') {
                              makeSearch(context);
                            } else if (fullReportController
                                    .selectedreport[0].report.scope ==
                                'BOTH') {
                              makeSearchApi(context);
                            }
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'جستجو',
                                  style: Responsive.isDesktop(context)
                                      ? CustomTextStyle()
                                          .textStyleDesktopkCardColor
                                      : CustomTextStyle()
                                          .textStyleTabletkCardColor,
                                ),
                                const Icon(Icons.search, color: kCardColor),
                              ]),
                        ),
                      ),
                    ),
                    SideMenuConstant().sizedBoxSideMenu,
                    for (var filterReport
                        in fullReportController.selectedreport[0].filters) ...[
                      if (filterReport.formItemInputType == 'TextBox' &&
                          filterReport.formItemType == 'String') ...[
                        ListTile(
                          title: MyTextFormFieldSideMenu(
                              myicon: Icon(
                                Icons.edit,
                                size: SideMenuConstant().iconSize,
                              ),
                              enable: filterReport.formItemValidationType ==
                                          'hardfix' ||
                                      filterReport.formItemValidationType ==
                                          'null'
                                  ? false
                                  : true,
                              textInputType: TextInputType.name,
                              labelTitle: filterReport.formItemDisplayTitle,
                              hintTitle: filterReport.formItemInputTypeHint,
                              errorTitle: filterReport.formItemValidationType ==
                                          'hardfix' ||
                                      filterReport.formItemValidationType ==
                                          'null'
                                  ? ''
                                  : filterReport.formItemValidationType,
                              myController: filterReport.textEditingController),
                        )
                      ],
                      if (filterReport.formItemInputType == 'TextBox' &&
                          filterReport.formItemType == 'Numeric') ...[
                        ListTile(
                          title: MyTextFormFieldSideMenuDigit(
                              enable: filterReport.formItemValidationType ==
                                          'hardfix' ||
                                      filterReport.formItemValidationType ==
                                          'null'
                                  ? false
                                  : true,
                              textInputType: TextInputType.number,
                              labelTitle: filterReport.formItemDisplayTitle,
                              hintTitle: filterReport.formItemInputTypeHint,
                              errorTitle: filterReport.formItemValidationType ==
                                          'hardfix' ||
                                      filterReport.formItemValidationType ==
                                          'null'
                                  ? ''
                                  : filterReport.formItemValidationType,
                              myicon: Icon(
                                Icons.edit,
                                size: SideMenuConstant().iconSize,
                              ),
                              myController: filterReport.textEditingController),
                        )
                      ],
                      if (filterReport.formItemInputType == 'Range' &&
                          filterReport.formItemType == 'DateTime') ...[
                        ListTile(
                            title: MyTextFormFilterFieldDateTime(
                                validation: filterReport.formItemValidationType,
                                labelTitle: filterReport.formItemDisplayTitle,
                                hintTitle: filterReport.formItemInputTypeHint,
                                errorTitle: filterReport.formItemValidationType,
                                //  myicon: Icon(Icons.search),
                                dateTimeController:
                                    filterReport.textEditingController)),
                        SideMenuConstant().sizedBoxSideMenu,
                      ],
                      if (filterReport.formItemInputType != 'Range' &&
                          filterReport.formItemType == 'DateTime') ...[
                        ListTile(
                            title: MyMultiTypeTextFormFilterFieldDateTime(
                                validation: filterReport.formItemValidationType,
                                labelTitle: filterReport.formItemDisplayTitle,
                                hintTitle: filterReport.formItemInputTypeHint,
                                errorTitle: filterReport.formItemValidationType,
                                name: filterReport.formItemTitle,
                                //  myicon: Icon(Icons.search),
                                dateTimeController:
                                    filterReport.textEditingController)),
                      ],
                      if (filterReport.formItemInputType == 'Range' &&
                          filterReport.formItemType == 'Numeric') ...[
                        ListTile(
                            title: MyTextFormFieldSideMenuDigit(
                                enable: filterReport.formItemValidationType ==
                                            'hardfix' ||
                                        filterReport.formItemValidationType ==
                                            'null'
                                    ? false
                                    : true,
                                textInputType: TextInputType.number,
                                labelTitle: filterReport.formItemDisplayTitle,
                                hintTitle: filterReport.formItemInputTypeHint,
                                errorTitle: filterReport
                                                .formItemValidationType ==
                                            'hardfix' ||
                                        filterReport.formItemValidationType ==
                                            'null'
                                    ? ''
                                    : filterReport.formItemValidationType,
                                myicon: Icon(
                                  Icons.edit,
                                  size: SideMenuConstant().iconSize,
                                ),
                                myController:
                                    filterReport.textEditingController)),
                      ],
                      if (filterReport.formItemInputType == 'DropDown') ...[
                        ListTile(
                            title: MySearchableDropDown(
                                labelTitle: filterReport.formItemDisplayTitle,
                                nameDropDown: filterReport.formItemTitle,
                                myItems: filterReport.items,
                                hintTitle: filterReport.formItemInputTypeHint,
                                errorTitle: filterReport.formItemValidationType,
                                controller: dropdownController,
                                myController:
                                    filterReport.textEditingController))
                      ],
                      if (filterReport.formItemInputType == 'CheckBox') ...[
                        ListTile(
                            title: MyChoiceBox(
                                labelTitle: filterReport.formItemDisplayTitle,
                                nameCheckBox: '',
                                myItems: filterReport.items,
                                hintTitle: filterReport.formItemInputTypeHint,
                                errorTitle: filterReport.formItemValidationType,
                                myController:
                                    filterReport.textEditingController)),
                      ],
                      if (filterReport.formItemInputType ==
                          'MultiChoiceBox') ...[
                        ListTile(
                            title: MyFormBuilderFilterChip(
                          labelTitle: filterReport.formItemDisplayTitle,
                          items: filterReport.items,
                          hintTitle: filterReport.formItemInputTypeHint,
                          // errorTitle: filterReport.formItemValidationType,
                          myController: filterReport.textEditingController,
                          name: '',
                        )),
                      ],
                      if (filterReport.formItemInputType == 'TextBox' &&
                          filterReport.formItemType != 'String' &&
                          filterReport.formItemType != 'DateTime' &&
                          filterReport.formItemType != 'Numeric' &&
                          filterReport.formItemType != 'Range') ...[
                        ListTile(
                          title: MyTextFormFieldSideMenu(
                              enable: filterReport.formItemValidationType ==
                                          'hardfix' ||
                                      filterReport.formItemValidationType ==
                                          'null'
                                  ? false
                                  : true,
                              myicon: Icon(
                                Icons.edit,
                                size: SideMenuConstant().iconSize,
                              ),
                              labelTitle: filterReport.formItemDisplayTitle,
                              hintTitle: filterReport.formItemInputTypeHint,
                              errorTitle: filterReport.formItemValidationType ==
                                          'hardfix' ||
                                      filterReport.formItemValidationType ==
                                          'null'
                                  ? ''
                                  : filterReport.formItemValidationType,
                              myController: filterReport.textEditingController),
                        )
                      ],
                    ],
                  ],
                ]),
          )
        : Drawer(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(0),
              ),
            ),
            // shape: ShapeBorder.lerp(null, null, 0),
            backgroundColor: kPrimaryColor,
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  title: Icon(
                    Icons.arrow_forward,
                    size: SideMenuConstant().iconSize,
                    color: kCardColor,
                  ),
                  onTap: () {
                    for (var filterReport
                        in fullReportController.selectedreport[0].filters) {
                      filterReport.textEditingController.text = '';
                    }
                    dropdownController.resetDropdowns();
                    sideMenusController.toggleDrawer();
                  },
                )
              ],
            ),
          ));
  }
}
