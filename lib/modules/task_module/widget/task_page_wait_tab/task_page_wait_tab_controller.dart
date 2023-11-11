import 'package:get/get.dart';

import '../../../../app/data/task.dart';
import '../../task_controller.dart';

class TaskPageWaitTabController extends GetxController {
  TaskPageController taskPageController = Get.find();

  List<TaskModel> getWaitList() {
    List<TaskModel> retVal = taskPageController.filteredTaskList.value;
    List<TaskModel> returnVal = [];
    List<TaskModel> returnValue = [];

    for (var e in taskPageController.filteredTaskList.value) {
      for (var i in taskPageController.statusTaskList.value) {
        if (e.taskId == i.taskId) {
          if (i.status == 'finished') {
            returnVal.add(e);
          }
        }
      }
    }
    returnValue = retVal.where((item) => !returnVal.contains(item)).toList();
    return returnValue.reversed.toList();
  }

  List<TaskModel> getWaitFavList() {
    List<TaskModel> retVal = getWaitList();
    List<TaskModel> returnVal = [];
    List<TaskModel> returnValue = [];

    for (var e in retVal) {
      for (var i in taskPageController.statusTaskList.value) {
        if (e.taskId == i.taskId) {
          if (i.status == 'fav') {
            returnVal.add(e);
          }
        }
      }
    }
    returnValue = retVal.where((item) => !returnVal.contains(item)).toList();
    return returnValue.reversed.toList();
  }
}
