import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cam/modules/task_module/task_service.dart';

import '../../app/data/task.dart';
import '../base_module/base_controller.dart';

class TaskPageController extends GetxController
    with GetSingleTickerProviderStateMixin, TaskService {
  BaseController userController = Get.find();

  final TextEditingController textController = TextEditingController();

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    filteredTaskList.bindStream(listPostByClassFromUser());
    tabController = TabController(vsync: this, length: 3);
    taskListByClassFromUser.bindStream(listPostByClassFromUser());
    statusTaskList.bindStream(getStatusStreamFromUser());
    ever(userController.userClasses, _updateTaskPage);
  }

  Rx<List<UserTaskStatusViewModel>> statusTaskList =
      Rx<List<UserTaskStatusViewModel>>([]);

  Rx<List<TaskModel>> filteredTaskList = Rx<List<TaskModel>>([]);
  Rx<List<TaskModel>> taskListByClassFromUser = Rx<List<TaskModel>>([]);

  var isSearching = false.obs;

  Future<void> deleteTask(String taskId) async {
    try {
      await deleteTaskFromDB(taskId);
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<TaskModel>> listPostByClassFromUser() {
    try {
      return listTaskByClassFromUserFromDB(userController.userModel);
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<UserTaskStatusViewModel>> getStatusStreamFromUser() {
    try {
      return getStatusStream(userController.userModel!.uid);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editStatusTask(taskId, String status) async {
    try {
      UserTaskStatusViewModel userTaskStatusViewModel = UserTaskStatusViewModel(
          uid: userController.userModel!.uid, taskId: taskId, status: status);
      await editStatusTaskToDB(userTaskStatusViewModel);
    } catch (e) {
      rethrow;
    }
  }

  _updateTaskPage(v) async {
    filteredTaskList.value = await getTaskClass(userController.userClasses);
  }

  //Search Filter
  final RxString _search = ''.obs;

  setSearch(value) => _search.value = value;

  setIsSearching(v) => isSearching.value = v;

  void runFilter(String enteredKeyword) {
    List<TaskModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = taskListByClassFromUser.value;
    } else {
      results = taskListByClassFromUser.value
          .where((task) =>
              task.description
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              task.className
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    filteredTaskList.value = results;
  }

  void resetSearch() {
    setSearch('');
  }
}
