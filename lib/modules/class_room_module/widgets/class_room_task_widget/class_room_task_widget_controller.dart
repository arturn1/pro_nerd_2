import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../../../../app/data/room.dart';
import '../../../../app/data/task.dart';
import 'class_room_task_widget_service.dart';

class ClassRoomTaskWidgetController extends GetxController
    with ClassRoomTaskWidgetService, GetSingleTickerProviderStateMixin {
  RoomModel roomModel = Get.arguments;

  late final AnimationController animationController;

  @override
  onInit() {
    super.onInit();
    taskListByClass.bindStream(getTaskStream());
    filteredTaskList.bindStream(getTaskStream());
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
  }

  Rx<List<TaskModel>> taskListByClass = Rx<List<TaskModel>>([]);
  Rx<List<TaskModel>> filteredTaskList = Rx<List<TaskModel>>([]);

  Stream<List<TaskModel>> getTaskStream() {
    try {
      return getTaskStreamByClass(roomModel.classId);
    } catch (e) {
      rethrow;
    }
  }

  void runTaskFilter(DateTime? d) {
    List<TaskModel> results = [];
    results = taskListByClass.value
        .where((task) => task.datePublished?.day == d!.day)
        .toList();

    filteredTaskList.value = results;
  }


  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
