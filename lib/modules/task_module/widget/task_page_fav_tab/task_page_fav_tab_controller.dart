import 'package:get/get.dart';

import '../../../../app/data/task.dart';
import '../../task_controller.dart';

class TaskPageFavTabController extends GetxController {
  TaskPageController taskPageController = Get.find();

  List<TaskListModel> getFavList() {
    List<TaskListModel> retVal = [];

    for (var e in taskPageController.filteredTaskList.value) {
      for (var i in taskPageController.statusTaskList.value) {
        if (e.taskId == i.taskId) {
          if (i.status == 'fav') {
            TaskListModel taskListModel = TaskListModel(
                taskId: i.taskId,
                classId: e.classId,
                className: e.className,
                description: e.description,
                finalDate: e.finalDate,
                datePublished: DateTime.now(),
                status: i.status);

            retVal.add(taskListModel);
          }
        }
      }
    }
    return retVal.reversed.toList();
  }
}
