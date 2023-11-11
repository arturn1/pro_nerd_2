import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../class_room_controller.dart';
import 'class_room_post_card_widget.dart';

class ClassRoomPostWidget extends GetView<ClassRoomPageController> {
  const ClassRoomPostWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: controller.isDual.value == true ? 2 : 1,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ClassRoomPostCardWidget(
                snap: controller.classRoomPostWidgetController.filteredPostList
                    .value[index]);
          },
          childCount: controller
              .classRoomPostWidgetController.filteredPostList.value.length,
        ),
      ),
    );
  }
}
