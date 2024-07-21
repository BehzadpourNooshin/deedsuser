import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrortHandeling {
  //404

  String apiFailureTableNotFoundMessage =
      'جدول گزارش مورد نظر در پایگاه داده، یافت نشد';
  String apiFailureTableNotFoundMessageEnglish =
      'Table not found in database. tableName';
  String apiFailureReportNotFoundMessage = 'گزارش یافت نشد';
  String apiFailureReportNotFoundMessageEnglish =
      'Report not found with reportTitle';
  String apiFailurePersonalSettingNotFoundMessage = 'تنظیمات صفحه اول یافت نشد';
  String apiFailurePersonalSettingNotFoundMessageEnglish =
      'Personal Setting not found with reportTitle';
  String apiFailureReportroleReportNotFoundMessage =
      'دسترسی به گزارش مد نظر یافت نشد';
  String apiFailureReportroleReportNotFoundMessageEnglish =
      'ReportRole not found with report title';
  String apiFailureReportroleEmailNotFoundMessage =
      'دسترسی کاربر به گزارش مد نظر یافت نشد';
  String apiFailureReportroleEmailNotFoundMessageEnglish =
      'ReportRole not found with user email';
  String apiFailureEmailPasswordNotFoundMessage =
      'نام کاربری یا رمز عبور اشتباه است';
  String apiFailureEmailPasswordNotFoundMessageEnglish =
      'Either email or password is incorrect';
  String apiFailureLookupNotFoundMessage = 'مقدار اولیه یافت نشد';
  String apiFailureLookupNotFoundMessageEnglish = 'Lookup not found with id';
  String apiFailureLookupNotFoundGroupTitleMessage =
      'مقدار اولیه با گروه مدنظر یافت نشد';
  String apiFailureLookupNotFoundGroupTitleMessageEnglish =
      'Lookup not found with groupName and title';
  String apiFailureUserNotFoundMessage = 'نام کاربری یا رمز عبور یافت نشد';
  String apiFailureUserNotFoundMessageEnglish = 'User not found with email';

  String apiFailureDatabaseNotFoundMessage =
      'در حال حاضر اطلاعات پایگاه داده قابل دریافت نیست';
  String apiFailureDatabaseNotFoundMessageEnglish =
      'Could not find data from SQLServer Database';

  String apiFailureDataNotFoundMessage = 'در حال حاضر داده قابل دریافت نیست';
  String apiFailureDataNotFoundMessageEnglish =
      'Could not get data from SQLServer Database';
  String apiFailureRecordNotFoundMessage = 'در حال حاضر، رکوردی یافت نشد';
  String apiFailureRecordNotFoundMessageEnglish = 'No record was found';
  String apiFailurePSDatabaseNotFoundMessage =
      'در حال حاضر داده از پایگاه داده اصلی قابل دریافت نیست';
  String apiFailurePSDatabaseNotFoundMessageEnglish =
      'Could not get data from PostgresSQL Database';
  String apiFailureFileNotFoundMessage =
      'در حال حاضر فایل اصلی گزارش قابل دریافت نیست';
  String apiFailurePSDataNotFoundMessage =
      "'در حال حاضر داده از پایگاه داده اصلی قابل دریافت نیست';";

  String apiFailurePSDataNotFoundMessageEnglish =
      "Could not find data from PostgresSQL Database";
  String apiFailureFileNotFoundMessageEnglish =
      'Could not find the file with the name';
  String apiFailureUserTokenNotFoundMessage = 'نام کاربری یا رمز عبور یافت نشد';
  String apiFailureUserTokenNotFoundMessageEnglish =
      'Either token or username & password could not be found';
  String apiFailureDefault404Message = 'قابل دریافت نیست';

//403
  String apiFailureCSVPermissionMessage =
      'دسترسی غیر مجاز برای ایجاد فایل منبع داده ';
  String apiFailureCSVPermissionMessageEnglish =
      'Current user does not have access to create table from csv';
  String apiFailureReportPermissionMessage = 'دسترسی غیر مجاز به گزارش';
  String apiFailureReportPermissionMessageEnglish =
      'Current user does not have access to the selected report';
  String apiFailureDefault403Message = 'دسترسی غیر مجاز';

  //401
  String apiFailureTokenExpiredMessage = 'توکن منقضی شده است، مجدد وارد شوید';
  String apiFailureTokenExpiredMessageEnglish = 'The token has expired';
  String apiFailureTokenInvalidMessage = 'توکن نا معتبر';
  String apiFailureTokenInvalidMessageEnglish = 'The token is not valid';
  String apiFailureDefault401Message = 'خطای احراز هویت';

  //408
  String apiFailureConnectToDatabaseMessage = 'ارتباط با پایگاه داده ممکن نیست';
  String apiFailureConnectToDatabaseMessageEnglish =
      'Could not connect to SQLServer Database';

  //409
  String apiFailureDuplicateUserMessage = 'نام کاربری تکراری است';
  String apiFailureDuplicateUserMessageEnglish = 'User exists with email';
  String apiFailureDuplicateLookupMessage =
      'گروه و عنوان مقدار اولیه تکراری است';
  String apiFailureDuplicateLookupMessageEnglish =
      'Record with the following groupName and title exists in lookup table';
  String apiFailureDuplicateReportRoleMessage =
      'دسترسی کاربر به گزارش تکراری است';
  String apiFailureDuplicateReportRoleMessageEnglish =
      'has access to report with title';
  String apiFailureDuplicateSessionMessage = 'در حال حاضر کاربر نشست فعال دارد';
  String apiFailureDuplicateSessionMessageEnglish =
      'User is already logged in with an active session.';
  String apiFailureDuplicateReportMessage = 'گزارش تکراری است';
  String apiFailureDuplicateReportMessageEnglish =
      'Record with the following title exists in report table';
  String apiFailureDefault409Message = 'مورد تکراری است';

  //500
  String apiFailureReadFileMessage = 'فایل گزارش قابل خواندن نیست';
  String apiFailureReadFileMessageEnglish =
      'Could not read the file with the name';
  String apiFailureReadContentFileMessage =
      'محتوای فایل گزارش قابل خواندن نیست';
  String apiFailureReadContentFileMessageEnglish =
      'Could not parse the JSON content of the file';
  String apiFailureCreateContentFileMessage =
      'محتوای فایل گزارش قابل ویرایش نیست';
  String apiFailureCreateContentFileMessageEnglish =
      'Could not write the JSON content to the file';
  String apiFailureCurrentPasswordIsIncorrectMessage =
      'رمز عبور فعلی صحیح نیست';
  String apiFailureCurrentPasswordIsIncorrectMessageEnglish =
      'Current password is incorrect';
  String apiFailureFormatAPIMessage = 'فرمت سرویس صحیح نیست';
  String apiFailureFormatAPIMessageEnglish = 'API Format is not correctly set';
  String apiFailureCreateJsonFileMessage = 'آدرس فایل json خالی است';
  String apiFailureCreateJsonFileMessageEnglish =
      'JSON file address is null and File is not saved.';
  String apiFailureRequiredParamMessage = 'فیلد اجباری است';
  String apiFailureRequiredParamMessageEnglish = 'Missing resource parameter';

  String apiFailureTimeOut = 'اندکی بعد تلاش کنید';
  String apiFailureDefaultMessage = 'اندکی بعد تلاش کنید';
}

class GeneralConstant {
  String apiCallSuccessdDeactiveMessage = 'با موفقیت غیر فعال شد';
  String apiCallFailureMessage = 'اندکی بعد تلاش کنید';
  String apiCallForbiddenMessage = 'دسترسی غیر مجاز';
  String apiCallSuccessUpdateMessage = 'با موفقیت به روز رسانی شد';
  String apiCallSuccessSubmitMessage = 'با موفقیت ثبت شد';
  String apiFailureExpirationToken = 'توکن منقضی شده است';
  String apiFailureDuplicationSession = 'در حال حاضر نشست فعال دارید';
  String apiCallSuccessDeleteMessage = 'با موفقیت حذف شد';
  String permissiontMessage = 'خطای دسترسی';
  String permissiontSubMessage = 'دسترسی غیر مجاز';

  String cancelText = 'لغو';
  String submitText = 'ثبت';
  String searchText = 'جستجو';
  String snackbarErrorTitle = 'خطا';
  String snackbarSuccessTitle = 'موفق';
  String snackbarEmptyError = 'پرکردن موارد الزامی است';
  String waitingApiCall = 'لطفا منتظر بمانید';
  double distanceHeight = 20;
}

class ChartConstant {
  Map<String, dynamic> dialog = {
    'name': 'نمودارها',
    'icon': const Icon(Icons.close)
  };
}

class TablesConstant {
  String excelText = 'اکسل';
  String pdfText = 'پی‌دی‌اف';
  String chartText = 'نمودار';
  String createUser = 'ایجاد کاربر';
  String updateUser = 'ویرایش کاربر';
  String actionText = 'عملیات';
  String permissionText = 'دسترسی‌ها';
  String reportsText = 'گزارشات';
  String groupRportsText = 'گروه گزارشات';
  String genderText = 'جنسیت';
  String activeText = 'فعال';
  String mobileNumberText = 'شماره موبایل';
  String roleText = 'نقش';
  String passwordText = 'رمز عبور';
  String currentPasswordText = 'گذر واژه جاری';
  String confirmPasswordText = 'تایید گذر واژه جدید';
  String newPasswordText = 'گذر واژه جدید';
  String returnToAccountTable = 'بازگشت‌ به‌ صفحه‌کاربران';
  String emailText = 'ایمیل';
  String lastNameText = 'نام‌خانوادگی';
  String addressText = 'نشانی';
  String firstNameText = 'نام';
  double tableHeight = Get.height * 1000;
  double boxDecorationRadius = 10;
  String toolTipDeactive = 'غیرفعال';
  String toolTipEdit = 'ویرایش';
  String toolTipAccessReport = 'دسترسی به گزارشات';
  String newButtonText = 'جدید';
  String searchButtonText = 'جستجو';
  double searchWidth = Get.width / 6.5;
  double buttonhWidth = Get.width / 13;
  double buttonhHeight = Get.height / 13;
  double searchHieght = Get.height / 15;
  double boxDecorationSearchRadius = 12;
  String toolTipActiveAccess = 'افزودن به صفحه اول';
  String toolTipDeactiveAccess = 'حذف از صفحه اول';
}

class ChangePasswordConstantText {
  String currentPasswordTextField = 'رمز عبور فعلی';
  String currentPasswordError = 'رمز عبور فعلی الزامی است';
  String newPasswordTextField = 'رمز عبور جدید';
  String newPasswordError = 'رمز عبور جدید الزامی است';
  String confirmPasswordEmptyError = 'تایید رمز عبور الزامی است';
  String confirmPasswordTextField = 'تایید رمز عبور جدید';
  String confirmPasswordError = 'عدم تطبیق رمز عبور';
}

class LoginPageConstantText {
  String mainTitle = 'سامانه مشاهده گزارشات';
  String userNameTextField = 'نام کاربری';
  String userNameError = '.نام کاربری الزامی است';
  String passwordTextField = 'رمز عبور';
  String passwordError = '.رمز عبور الزامی است';
  String apiErrorTitle = 'خطا';
  String apiEmptySubTitle = '.نام کاربری و رمز عبور الزامی است';
  String apiIncorrectSubTitle = '.نام کاربری یا رمز عبور اشتباه است';
  String loginButton = 'ورود';
  Icon userNameIcon = const Icon(Icons.account_box, size: 20);
  TextDirection userNameDirection = TextDirection.ltr;
  TextAlign userNameTextAlign = TextAlign.left;
  Icon passwordIcon = const Icon(Icons.lock);
  TextDirection passwordDirection = TextDirection.ltr;
  TextAlign passwordTextAlign = TextAlign.left;
}

class HeaderConstantText {
  String title = 'سامانه دیدزنی شرکت مخابرات ایران';
  String subtitle = 'معاونت فناوری اطلاعات';
  String logoPath = 'assets/images/Icon-50.png';
  String userNameError = '.نام کاربری الزامی است';
  String passwordTextField = 'رمز عبور';
  String passwordError = '.رمز عبور الزامی است';
  String apiErrorTitle = 'خطا';
  String apiEmptySubTitle = '.نام کاربری و رمز عبور الزامی است';
  String apiIncorrectSubTitle = '.نام کاربری یا رمز عبور اشتباه است';
  String loginButton = 'ورود';
}

class DashboardConstant {}

class MainPageConstant {
  int headerDuration = 300;
  int sideMenuDeuration = 150;
  double openWidthOneSideMenuMainPage = Get.width - Get.width / 7;
  double openWidthOneSideMenu = Get.width / 7;

  double openWidthOneSideMenuMainPageReportView = Get.width - Get.width / 5.18;
  double closeWidthOneSideMenuMainPageReportView = Get.width - Get.width / 13;

  double closeWidthOneSideMenuMainPage = Get.width - Get.width / 20;
  double closeWidthOneSideMenu = Get.width / 20;

  double openWidthBothSideMenuMainPage = Get.width - Get.width / 3.5;
  double closeWidthBothSideMenuMainPage = Get.width - Get.width / 10;
}

class NoteConstant {
  String notification = 'پیام‌ها';
  Map<String, dynamic> notes = {
    'name': 'پیام‌ها',
    'icon': const Icon(Icons.message)
  };
  String version = 'نسخه';
}

class SideMenuConstant {
  double heightButton = Get.height / 16;
  double transform = 80;
  int millisec = 500;
  Map<String, dynamic> dashboard = {'name': 'پیشخوان', 'icon': Icons.home};
  Map<String, dynamic> account = {
    'name': 'حساب کاربری',
    'icon': Icons.account_box
  };
  Icon closeSideMenu = const Icon(Icons.arrow_forward, color: kCardColor);
  Icon openSideMenu = const Icon(Icons.arrow_back, color: kCardColor);
  Map<String, dynamic> exit = {'name': 'خروج', 'icon': Icons.exit_to_app};
  Map<String, dynamic> report = {'name': 'گزارشات', 'icon': Icons.table_view};
  String apiErrorTitle = 'خطا';
  String apiEmptySubTitle = 'گزارش فاقد داده است';
  String apiEmptyFilter = 'پارامترهای جستجو را کامل نمایید';
  String accountproperties = 'جزییات حساب کاربری';

  String timer = 'زمان باقی‌مانده';
  Divider sidemenudivider = Divider(
    height: Get.height / 50,
    thickness: 1,
  );
  SizedBox sizedBoxSideMenu = SizedBox(height: Get.height / 60);
  double scrollbarTickness = 10;
  double heightInternal = Get.height / 3;
  Map<String, dynamic> changePassword = {
    'name': 'تغییر رمز عبور',
    'icon': const Icon(Icons.password)
  };

  Map<String, dynamic> currentPassword = {
    'name': 'رمز عبور فعلی',
    'icon': const Icon(Icons.password)
  };
  Map<String, dynamic> newPassword = {
    'name': 'رمز عبور جدید',
    'icon': const Icon(Icons.password)
  };
  Map<String, dynamic> confirmPassword = {
    'name': 'تایید رمز عبور',
    'icon': const Icon(Icons.password)
  };
  Map<String, dynamic> dialogPassword = {
    'name': 'تغییر رمز عبور',
    'icon': const Icon(Icons.close)
  };
  Map<String, dynamic> dialog = {
    'name': 'ویرایش حساب کاربری',
    'icon': const Icon(Icons.close)
  };
  Map<String, dynamic> firstname = {
    'name': 'نام',
    'icon': const Icon(Icons.edit_note)
  };
  Map<String, dynamic> lastname = {
    'name': 'نام خانوادگی',
    'icon': const Icon(Icons.edit_note)
  };
  Map<String, dynamic> mobile = {
    'name': ' شماره موبایل',
    'icon': const Icon(Icons.mobile_friendly)
  };
  Map<String, dynamic> email = {
    'name': 'ایمیل',
    'icon': const Icon(Icons.email)
  };
  Map<String, dynamic> password = {
    'name': 'پسورد',
    'icon': const Icon(Icons.lock_open)
  };
  Map<String, dynamic> address = {
    'name': 'آدرس',
    'icon': const Icon(Icons.edit_location)
  };
  Map<String, dynamic> myfavorite = {
    'name': 'تنظیمات صفحه اول',
    'icon': const Icon(Icons.settings)
  };
  Map<String, dynamic> myhitory = {
    'name': 'تاریخچه',
    'icon': const Icon(Icons.history_rounded)
  };
  String validateUpdateAccount = "فیلد اجباری*";
  String editAccountButton = 'ویرایش';
  String editAccountButtonToggle = 'انصراف';
  String updateUserError = 'api خطا در فراخوانی';
  String updateUserSuccess = 'با موفقیت به روز رسانی شد';
  double iconSize = 19;
}

class Styles {
  ButtonStyle mainStyleButton = ButtonStyle(
    overlayColor: WidgetStateProperty.all(kCardColor.withOpacity(0.2)),
    backgroundColor: WidgetStateProperty.all(kPrimaryColor),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
  ButtonStyle disableStyleButton = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(kCancelButtonColor),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
  ButtonStyle mainEndSideMenuStyleButton = ButtonStyle(
    overlayColor: WidgetStateProperty.all(kCardColor.withOpacity(0.2)),
    backgroundColor: WidgetStateProperty.all(kPrimaryColor),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
  ButtonStyle mainStyleButtonToggle = ButtonStyle(
    overlayColor: WidgetStateProperty.all(kPrimaryColor.withOpacity(0.2)),
    backgroundColor: WidgetStateProperty.all(kCardColor),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
  ButtonStyle sideBarStyleButton = ButtonStyle(
    overlayColor: WidgetStateProperty.all(kCardColor.withOpacity(0.2)),
    fixedSize: WidgetStateProperty.all(Size.fromWidth(Get.width / 1.8)),
    backgroundColor: WidgetStateProperty.all(kPrimaryColor),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
  ButtonStyle dateTimeStyleButton = ButtonStyle(
    overlayColor: WidgetStateProperty.all(kCardColor.withOpacity(0.2)),
    // fixedSize: WidgetStateProperty.all(Size.fromWidth(Get.width / 1.8)),
    //  backgroundColor: WidgetStateProperty.all(kCardColor),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(
              color: kSecondaryColor, style: BorderStyle.solid)),
    ),
  );
  ButtonStyle mainSearchPageStyleButton = ButtonStyle(
    overlayColor: WidgetStateProperty.all(kCardColor.withOpacity(0.2)),
    //fixedSize: MaterialStateProperty.all(Size.fromWidth(Get.width / 1.8)),
    backgroundColor: WidgetStateProperty.all(kPrimaryColor),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
    ),
  );
  ButtonStyle mainPageStyleButton = ButtonStyle(
    overlayColor: WidgetStateProperty.all(kPrimaryColor.withOpacity(0.2)),
    fixedSize: WidgetStateProperty.all(Size.fromWidth(Get.width / 1.8)),
    backgroundColor: WidgetStateProperty.all(kCardColor),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
}

const Color kPrimaryColor = Color(0xFF1E4EA3);
const Color kSecondaryColor = Color(0xFF6C757D);
const Color kErrorColor = Color(0xFFDC3545);
const Color kSuccessColor = Color(0xFF08A158);
const Color kInfoColor = Color(0xFF17A2B8);
const Color kWarningColor = Color(0xFFFFc107);

const Color kTextColor = Color(0xFF2A2B2D);

const Color kScreenBackgroundColor = Color(0xFFF4F6F9);
const kBlackColor = Colors.black87;
const kLightBlueColor = Color(0xFF5886FF);
const kDarktBlueColor = Color.fromARGB(255, 13, 71, 161);
const kLightGreyColor = Color(0xfff7f8fd);
const kDarkGreyColor = Color.fromARGB(248, 106, 106, 106);
const kCardColor = Colors.white;
const kLightGreenColor = Color.fromARGB(255, 86, 167, 127);
const kHoverColor = Colors.amber;
const kFocusColor = Colors.transparent;
const kswitchColor = Color(0Xff3CABBD);
const Color kSuccessColorAppButton = Color(0xFF08A158);
double kDefaultPadding = Get.width / 92;
const kCyanColor = Color(0Xff3CABBD);
const kNextButtonColor = kPrimaryColor;
const kPrevoiusButtonColor = kSecondaryColor;
const kSubmitButtonColor = kPrimaryColor;
const kCancelButtonColor = kDarkGreyColor;
const kNewButtonColor = kPrimaryColor;
const kCard1Color = Color.fromARGB(255, 107, 99, 205);
const kEditButtonColor = Color.fromARGB(255, 15, 147, 168);
const kDeleteButtonColor = Color.fromARGB(255, 248, 116, 116);
const kSuccessapicolor = Color(0Xff3CABBD);
const kFailapicolor = Color.fromARGB(255, 248, 116, 116);
const double kTextPadding = 4.0;
const int flexCountDashboard = 5;
const double kScreenWidthSm = 576.0;
const double kScreenWidthMd = 768.0;
const double kScreenWidthLg = 992.0;
const double kScreenWidthXl = 1200.0;
const double kScreenWidthXxl = 1400.0;
const double kDialogWidth = 460.0;
const primaryColor = Color(0xFF685BFF);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);
