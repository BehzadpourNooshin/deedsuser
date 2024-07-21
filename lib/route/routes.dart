import 'package:deedsuser/views/pages/dashboardpage.dart';
import 'package:deedsuser/views/pages/favoritpage.dart';
import 'package:deedsuser/views/pages/loginpage.dart';
import 'package:deedsuser/views/pages/reportmarketplace.dart';
import 'package:deedsuser/views/pages/reportview.dart';
import 'package:get/get.dart';

class Routes {
  static List<GetPage> get pages => [
        GetPage(
          name: '/',
          page: () => const LoginPage(),
        ),
        GetPage(
          name: '/dashboardscreen',
          page: () => DashboardShowPage(),
          //  middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: '/reportview',
          page: () => const MyReportView(),
          //   middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: '/favortiereport',
          page: () => const FavoritePage(),
          //    middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: '/reportmarketplace',
          page: () => const ReporMarketPlacePage(),
          //    middlewares: [AuthMiddleware()],
        ),
      ];
}
