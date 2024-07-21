import 'package:deedsuser/controllers/apicall_controller.dart';
import 'package:deedsuser/controllers/category_controller.dart';
import 'package:deedsuser/controllers/login_controller.dart';
import 'package:deedsuser/controllers/loginresponse_controller.dart';
import 'package:deedsuser/controllers/user_controller.dart';
import 'package:deedsuser/functions/makeUserProperties.dart';
import 'package:deedsuser/models/login_model.dart';
import 'package:deedsuser/utils/api_service.dart';
import 'package:deedsuser/utils/constant.dart';
import 'package:get/get.dart';

Function login = (LoginController loginController,
    LoginResponseController loginResponseController,
    UserController userController,
    APICallController apiCallController,
    CategoryController categoryController) async {
  Get.toNamed('/dashboardscreen');
  (loginController.username.text.isEmpty ||
          loginController.password.text.isEmpty)
      ? {
          Get.snackbar(
            LoginPageConstantText().apiErrorTitle,
            LoginPageConstantText().apiEmptySubTitle,
            backgroundColor: kErrorColor,
            colorText: kCardColor,
          )
        }
      : await Network()
          .login(
              login: LoginModel(
                  email: loginController.username.text,
                  password: loginController.password.text,
                  role: 'ADMIN'))
          .then((value) {
          //   print(value);
          if (value == false) {
            Get.snackbar(
              LoginPageConstantText().apiErrorTitle,
              LoginPageConstantText().apiIncorrectSubTitle,
              backgroundColor: kErrorColor,
              colorText: kCardColor,
            );
          } else {
            userController.username.text = loginController.username.text;
            userController.password.text = loginController.password.text;
            userController.accesstoken.text =
                loginResponseController.accesstoken.text;

            userController.refreshtoken.text =
                loginResponseController.refreshtoken.text;
            userController.update();
            loginController.update();
            loginResponseController.update();
            makeUserProperties(userController);
            // reportbasetcategory(apiCallController, categoryController);
            Get.toNamed('/dashboardscreen');
          }
        });
};

// Function reportbasetcategory = (APICallController apiCallController,
//     CategoryController categoryController) async {
//   Get.toNamed('/reportview');
//   apiCallController.isLoading = !apiCallController.isLoading;
//   apiCallController.update();
//   await Network().reportbasetcategory().then(
//     (value) {
//       apiCallController.isLoading = !apiCallController.isLoading;
//       apiCallController.update();
//       if (value == false) {
//         Get.snackbar(
//           SideMenuConstant().apiErrorTitle,
//           SideMenuConstant().apiEmptySubTitle,
//           backgroundColor: kErrorColor,
//           colorText: kCardColor,
//         );
//       }
//       categoryController.showReport = !categoryController.showReport;
//       categoryController.update();
//       if (categoryController.showReport == true) {
//         categoryController.categories.clear();
//       }
//       //     apiCallController.isLoading?Get.toNamed(/): apiCallController.isLoading?Get.toNamed();
//     },
//   );
// };
// Function reportbasetcategory = (APICallController apiCallController,
//     CategoryController categoryController) async {
//   Get.toNamed('/reportview');
//   apiCallController.isLoading = !apiCallController.isLoading;
//   apiCallController.update();
//   await Network().reportbasetcategory().then(
//     (value) {
//       apiCallController.isLoading = !apiCallController.isLoading;
//       apiCallController.update();
//       if (value == false) {
//         Get.snackbar(
//           SideMenuConstant().apiErrorTitle,
//           SideMenuConstant().apiEmptySubTitle,
//           backgroundColor: kErrorColor,
//           colorText: kCardColor,
//         );
//       }
//       categoryController.showReport = !categoryController.showReport;
//       categoryController.update();
//       if (categoryController.showReport == true) {
//         categoryController.categories.clear();
//       }
//       //     apiCallController.isLoading?Get.toNamed(/): apiCallController.isLoading?Get.toNamed();
//     },
//   );
// };
