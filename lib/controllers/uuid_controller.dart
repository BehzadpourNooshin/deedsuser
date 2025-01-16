import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class UUIDController extends GetxController {
  final uuid = Uuid();
  late String generatedUUID;

  @override
  void onInit() {
    super.onInit();
    generatedUUID = uuid.v4(); // تولید UUID جدید هنگام ساخت کنترلر
  }

  String getUUID() {
    return generatedUUID;
  }
}
