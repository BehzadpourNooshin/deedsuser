import 'package:deedsuser/utils/constant.dart';
import 'package:get/get.dart';

class ErrorhandelingController extends GetxController {
  RxString errorTitleMessage = GeneralConstant().snackbarErrorTitle.obs;
  RxString errorSubTitleMessage = GeneralConstant().apiCallFailureMessage.obs;
}
