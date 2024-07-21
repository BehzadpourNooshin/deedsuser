import 'package:get/get.dart';

class MyOfflineReportsController extends GetxController {
  var selectedIndex = 0.obs;

  final List<Map<String, dynamic>> offlineReports = [
    {
      'reporttitle': 'نت بان',
      'reportdesc': 'گزارش وضعیت مصرف',
      'categoryid': '1',
      'categorytitle': 'گزارشات آفلاین',
      'reportid': 1
    },
    {
      'reporttitle': 'پورت‌های فعال مناطق',
      'reportdesc': 'پورت‌های فعال مناطق در 24 ساعت گذشته',
      'categoryid': '1',
      'categorytitle': 'گزارشات آفلاین',
      'reportid': 2
    },
    {
      'reporttitle': 'لینک اشباع',
      'reportdesc': 'گزارشات لینک اشباع مراکز',
      'categoryid': '1',
      'categorytitle': 'گزارشات آفلاین',
      'reportid': 4
    },
    {
      'reporttitle': 'گراف مصرف ',
      'reportdesc': 'گراف مصرف مشتری',
      'categoryid': '1',
      'categorytitle': 'گزارشات آفلاین',
      'reportid': 5
    },
  ];
}
