import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CornometerController extends GetxController {
  Rx<Duration> timerDuration = Duration(minutes: 20).obs;

  void updateTimerDuration(Duration remaining) {
    timerDuration.value = remaining;
    saveTimerDuration();
    update();
  }

  void saveTimerDuration() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('timer_duration', timerDuration.value.inSeconds);
    update();
  }

  void resetTimeDuration() {
    timerDuration.value = Duration(minutes: 20);
    saveTimerDuration();
    update();
  }

  void loadTimerDuration() async {
    final prefs = await SharedPreferences.getInstance();
    final int? seconds = prefs.getInt('timer_duration');
    if (seconds != null) {
      timerDuration.value = Duration(seconds: seconds);
    }
  }
}
