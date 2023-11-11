import 'package:get/get.dart';

import '../../../../app/data/task.dart';
import '../../task_controller.dart';

class TaskPageFinishedTabController extends GetxController {
  TaskPageController taskPageController = Get.find();

  List<TaskModel> getFinishedList() {
    List<TaskModel> retVal = [];

    for (var e in taskPageController.filteredTaskList.value) {
      for (var i in taskPageController.statusTaskList.value) {
        if (e.taskId == i.taskId) {
          if (i.status == 'finished') {
            retVal.add(e);
          }
        }
      }
    }
    return retVal;
  }
}
