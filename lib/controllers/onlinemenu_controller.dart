import 'package:get/get.dart';

class MyOnlineReportController extends GetxController {
  var selectedIndex = 0.obs;

  final List<Map<String, dynamic>> onlinereports = [
    {
      'reporttitle': 'دیدبان',
      'reportdesc': 'صورتحساب ده دوره اخیر مشترک',
      'categoryid': '2',
      'categorytitle': 'گزارشات استعلامی',
      'reportid': 3
    },
    {
      'reporttitle': 'دیدبان',
      'reportdesc': 'مصرف اینترنت مشترک',
      'categoryid': '2',
      'categorytitle': 'گزارشات استعلامی',
      'reportid': 6
    },
    {
      'reporttitle': 'دیدبان',
      'reportdesc': 'استعلام هویت مشترک',
      'categoryid': '2',
      'categorytitle': 'گزارشات استعلامی',
      'reportid': 7
    }
  ];
}
