import 'package:deedsuser/controllers/apicall_controller.dart';
import 'package:deedsuser/controllers/errorhandeling_controller.dart';
import 'package:deedsuser/controllers/expantion_controller.dart';
import 'package:deedsuser/controllers/filter_controller.dart';
import 'package:deedsuser/controllers/full_report_controller.dart';
import 'package:deedsuser/controllers/loginresponse_controller.dart';
import 'package:deedsuser/controllers/reportsbycategory_controller.dart';
import 'package:deedsuser/controllers/resultsearch_controller.dart';
import 'package:deedsuser/controllers/search_controller.dart';
import 'package:deedsuser/functions/dialog.dart';
import 'package:deedsuser/utils/api_service.dart';
import 'package:deedsuser/utils/constant.dart';
import 'package:deedsuser/utils/responsive.dart';
import 'package:deedsuser/views/widgets/summarycard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Reportmarketplace extends StatelessWidget {
  const Reportmarketplace({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(kDefaultPadding / 2),
      child: const CategoryExpansionTile(),
    );
  }
}

class CategoryExpansionTile extends StatelessWidget {
  const CategoryExpansionTile({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool? formOpenFlag = true.obs;
    ResultSearchController resultSearchController =
        Get.put(ResultSearchController());
    OptionSearchController optionSearchController =
        Get.put(OptionSearchController());
    FullReportController fullReportController = Get.put(FullReportController());
    LoginResponseController loginResponseController =
        Get.put(LoginResponseController());
    APICallController apiCallController = Get.put(APICallController());
    ReportsByCategoryController reportsByCategoryController =
        Get.put(ReportsByCategoryController());

    ErrorhandelingController errorhandelingController =
        Get.put(ErrorhandelingController());
    FilterController formController = Get.put(FilterController());

    ExpantionController expantionController = Get.put(ExpantionController());
    return Obx(
      () => Column(
        children: reportsByCategoryController.reportsbycategoryshowmarketplace
            .map((category) {
          return Column(
            children: [
              Card(
                color: kCardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    iconTheme: const IconThemeData(color: kPrimaryColor),
                    colorScheme: const ColorScheme.light(
                      primary: kSecondaryColor,
                    ),
                  ),
                  child: Obx(() => ExpansionTile(
                        onExpansionChanged: (val) {
                          val = expantionController.selectedCategory.contains(
                                      category.categoryDisplayTitle) ||
                                  expantionController.selectedCategory.isEmpty
                              ? true
                              : false;

                          formOpenFlag.value = val;
                        },
                        maintainState: true,
                        initiallyExpanded: expantionController.selectedCategory
                                    .contains(category.categoryDisplayTitle) ||
                                expantionController.selectedCategory.isEmpty
                            ? true
                            : false,
                        backgroundColor: kCardColor,
                        collapsedBackgroundColor: kLightGreyColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        collapsedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        title: Text(
                          textAlign: TextAlign.end,
                          category.categoryDisplayTitle,
                          style: Responsive.isDesktop(context)
                              ? CustomTextStyle()
                                  .textStyleDesktopKprimaryColorTitr
                              : CustomTextStyle()
                                  .textStyleTabletKprimaryColorTitr,
                        ),
                        trailing: Icon(
                          FontAwesomeIcons.chartPie,
                          color: kPrimaryColor,
                          size: SideMenuConstant().iconSize,
                        ),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(kDefaultPadding / 2),
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              spacing: kDefaultPadding /
                                  2, // Space between cards horizontally
                              runSpacing: kDefaultPadding /
                                  2, // Space between rows vertically
                              children: category.reports.map((report) {
                                return SizedBox(
                                    width: Get.width / 5 -
                                        16, // Adjust width to fit three cards in a row, considering spacing
                                    child: Card(
                                      color: kCardColor,
                                      elevation: 4.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.all(kDefaultPadding / 2),
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors
                                              .click, // Change cursor to click
                                          child: GestureDetector(
                                            onTap: () async {
                                              resultSearchController.datarows
                                                  .clear();
                                              resultSearchController.headers
                                                  .clear();
                                              optionSearchController.searchs
                                                  .clear();
                                              fullReportController
                                                  .selectedreport
                                                  .clear();
                                              fullReportController.update();
                                              apiCallController.isLoading =
                                                  !apiCallController.isLoading;
                                              apiCallController.update();
                                              showDialogApiCallBefore(context);
                                              await Network().refreshToken();
                                              await Network()
                                                  .getreportbyname(
                                                      reportName:
                                                          report.reportName,
                                                      accessToken:
                                                          loginResponseController
                                                              .accesstoken.text)
                                                  ?.then((value) async {
                                                if (formController
                                                    .filter.isEmpty) {
                                                  errorhandelingController
                                                              .errorTitleMessage
                                                              .value ==
                                                          'خطای نشست'
                                                      ? {
                                                          await loginResponseController
                                                              .logout(401)
                                                        }
                                                      : errorhandelingController
                                                                  .errorTitleMessage
                                                                  .value ==
                                                              'خطای توکن'
                                                          ? await loginResponseController
                                                              .logout(409)
                                                          : Network.showInternetError(
                                                              context,
                                                              errorhandelingController
                                                                  .errorSubTitleMessage
                                                                  .value);
                                                }
                                                apiCallController.isLoading =
                                                    !apiCallController
                                                        .isLoading;
                                                apiCallController.update();
                                                // ignore: use_build_context_synchronously
                                                apiCallAfter(context);
                                                Get.toNamed('/reportview');
                                              });
                                            },
                                            child: SummaryCardInfoReport(
                                              value: report.displayTitle,
                                              backgroundColor: kCardColor,
                                              textColor: kSecondaryColor,
                                              iconColor: kPrimaryColor,
                                              width: Get.width / 3 -
                                                  32, // Adjust width to fit padding
                                            ),
                                          ),
                                        ),
                                      ),
                                    ));
                              }).toList(),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
