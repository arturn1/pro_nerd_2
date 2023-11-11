import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cam/modules/home_module/widgets/task_widget/task_home_widget_service.dart';

import '../../../../app/data/task.dart';
import '../../../base_module/base_controller.dart';

class TaskHomeWidgetController extends GetxController
    with GetSingleTickerProviderStateMixin, TaskHomeWidgetService {
  BaseController userController = Get.find();

  late final AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    taskListByClassFromUser.bindStream(getTask());
    statusTaskList.bindStream(getStatusStreamFromUser());
    ever(userController.userClasses, updateTaskHome);

    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
  }

  Rx<List<UserTaskStatusViewModel>> statusTaskList =
  Rx<List<UserTaskStatusViewModel>>([]);


  Rx<List<TaskModel>> taskListByClassFromUser = Rx<List<TaskModel>>([]);

  Stream<List<TaskModel>> getTask() {
    try {
      return getTaskClassByUser(userController.userClasses);
    } catch (e) {
      rethrow;
    }
  }

  updateTaskHome(v) async {
    taskListByClassFromUser.value =
    await getTaskClass(userController.userClasses);
  }

  List<TaskModel> getWaitList() {
    List<TaskModel> retVal = taskListByClassFromUser.value;
    List<TaskModel> returnVal = [];
    List<TaskModel> returnValue = [];

    for (var e in taskListByClassFromUser.value) {
      for (var i in statusTaskList.value) {
        if (e.taskId == i.taskId) {
          if (i.status == 'finished') {
            returnVal.add(e);
          }
        }
      }
    }
    returnValue = retVal.where((item) => !returnVal.contains(item)).toList();
    return returnValue;
  }

  Stream<List<UserTaskStatusViewModel>> getStatusStreamFromUser() {
    try {
      return getStatusStream(userController.userModel!.uid);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
