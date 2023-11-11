import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cam/modules/class_room_module/widgets/class_room_post_widget/class_room_post_widget_controller.dart';
import 'package:cam/modules/class_room_module/widgets/class_room_task_widget/class_room_task_widget_controller.dart';
import '../../app/data/room.dart';
import '../base_module/base_controller.dart';
import 'class_room_service.dart';

class ClassRoomPageController extends GetxController with ClassService {
  BaseController userController = Get.find();

  @override
  void onInit() {
    super.onInit();
    getUserIsFollowing(roomModel);
  }

  Rx<bool> showblur = false.obs;

  Rx<Widget> alertWidget = Container().obs;

  RxBool isDual = RxBool(false);

  void setDual() => isDual.value = !isDual.value;

  RoomModel roomModel = Get.arguments;

  ClassRoomPostWidgetController classRoomPostWidgetController =
      Get.put(ClassRoomPostWidgetController());

  ClassRoomTaskWidgetController classRoomTaskWidgetController =
      Get.put(ClassRoomTaskWidgetController());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Rx<List<RoomModel>> classListByUser = Rx<List<RoomModel>>([]);
  RxBool isFollowing = false.obs;

  setIsFollowing(v) => isFollowing.value = v;

  Future<bool> getUserIsFollowing(RoomModel snap) async {
    return setIsFollowing(
        await getUserIsFollowingFromDB(snap.classId, userController.userModel));
  }

  Future<void> followClass(String classId) async {
    var b = await getUserIsFollowingFromDB(classId, userController.userModel);
    if (b == false) {
      followClassToDB(classId, userController.userModel);
      userController.userClasses.add(classId);
      setIsFollowing(!b);
    } else {
      unfollowClassToDB(classId, userController.userModel);
      userController.userClasses.remove(classId);
      setIsFollowing(!b);
    }
  }

  //Search fields
  var isSearchingClassRoomScreenFilter = false.obs;

  setIsSearchingClassRoomScreenFilter() => isSearchingClassRoomScreenFilter.value =
      !isSearchingClassRoomScreenFilter.value;

  setIsSearchingClassRoomScreenFilterFalse() => isSearchingClassRoomScreenFilter.value = false;

  resetFilter() async {
    classRoomPostWidgetController.filteredPostList.value =
        await classRoomPostWidgetController.getPostClass(roomModel.classId);
    classRoomTaskWidgetController.filteredTaskList.value =
        await classRoomTaskWidgetController.getTaskClass(roomModel.classId);
  }
}
