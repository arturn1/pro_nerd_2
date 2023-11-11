import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../app/data/room.dart';
import '../../app/data/task.dart';
import '../../core/utils/verify_data.dart';
import '../../core/values/constants.dart';
import '../base_module/base_controller.dart';
import '../task_module/task_service.dart';

class AddTaskPageController extends GetxController with TaskService {

  BaseController userController = Get.find();

  @override
  void onInit() {
    super.onInit();
    classesList.bindStream(classStream());
  }

  final RxString _classId = "".obs;

  setClassId(String value) => _classId.value = value;

  final RxString _className = "".obs;

  setClassName(String value) => _className.value = value;

  String get className => _className.value;

  final RxString _description = "".obs;

  setDescription(String value) => _description.value = value;

  final RxBool _isDone = false.obs;

  setIsDone(bool value) => _isDone.value = value;

  getIsDone() => _isDone.value;

  Rx<List<RoomModel>> classesList = Rx<List<RoomModel>>([]);

  List<RoomModel> get classes => classesList.value;

  Future<void> addTask() async {
    try {
      String taskId = const Uuid().v1();
      TaskModel taskModel = TaskModel(
          taskId: taskId,
          classId: _classId.value,
          className: _className.value,
          description: _description.value,
          finalDate: DatePickerHelper.instance.pickedDate!.value,
          datePublished: DateTime.now(),
          isDone: _isDone.value);

      UserTaskStatusViewModel userTaskStatusViewModel = UserTaskStatusViewModel(
          uid: userController.userModel!.uid, status: 'wait', taskId: taskId);

      await addTaskToDB(taskModel);
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<RoomModel>> classStream() {
    return firestore
        .collection("rooms")
        .where("followers", arrayContains: userController.userModel!.uid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<RoomModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(RoomModel.fromSnap(element));
      }
      return retVal;
    });
  }

}