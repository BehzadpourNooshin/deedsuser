import 'package:deedsuser/models/updatenotes_model.dart';

import 'package:get/get.dart';

class UpdateNoteController extends GetxController {
  RxList<UpdatenotesModel> updateNotes = <UpdatenotesModel>[].obs;
  RxInt updateUserNote = 0.obs;
}
