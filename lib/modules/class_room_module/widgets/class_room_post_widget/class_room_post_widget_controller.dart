import 'package:get/get.dart';

import '../../../../app/data/post.dart';
import '../../../../app/data/room.dart';
import 'class_room_post_widget_service.dart';

class ClassRoomPostWidgetController extends GetxController
    with ClassRoomPostWidgetService {
  RoomModel roomModel = Get.arguments;

  @override
  onInit() {
    super.onInit();
    postListByClass.bindStream(getPostStreamByClass(roomModel.classId));
    filteredPostList.bindStream(getPostStreamByClass(roomModel.classId));
  }

  Rx<List<PostModel>> postListByClass = Rx<List<PostModel>>([]);
  Rx<List<PostModel>> filteredPostList = Rx<List<PostModel>>([]);

  void runPostFilter(DateTime? d) {
    List<PostModel> results = [];
    results = filteredPostList.value
        .where((post) => post.datePublished.day == d!.day)
        .toList();

    filteredPostList.value = results;
  }



}
