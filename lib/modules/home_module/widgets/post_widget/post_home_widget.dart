import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cam/modules/home_module/widgets/post_widget/post_home_card_widget.dart';
import 'package:cam/modules/home_module/widgets/post_widget/post_home_widget_controller.dart';

import '../../../../core/values/constants.dart';
import '../../../base_module/base_controller.dart';

class PostHomeWidget extends GetView<PostHomeWidgetController> {
  const PostHomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BaseController baseController = Get.find();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Text(
            'Posts recentes',
            style: TextStyle(
              fontSize: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.fontSize,
            ),
          ),
        ),
        NotificationListener(
          onNotification: onNotification,
          child: GetX<PostHomeWidgetController>(
              init: Get.put(PostHomeWidgetController(), permanent: false),
              builder: (PostHomeWidgetController controller) {
                if (controller.postListByClassFromUser.value.isEmpty) {
                  return Container(
                      padding: const EdgeInsets.all(kPaddingDefault * 2),
                      child: Column(
                        children: const [
                          Text("Os posts dos seus grupos aparecerão aqui"),
                          Padding(
                            padding: EdgeInsets.all(kPaddingDefault * 2),
                            child: Center(
                                child: Icon(
                              Icons.camera,
                              size: 50,
                            )),
                          )
                        ],
                      ));
                } else {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 262,
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: controller
                              .postListByClassFromUser.value.isEmpty
                          ? controller.postListByClassFromUser.value.length
                          : controller.postListByClassFromUser.value.length > 3
                              ? 4
                              : controller.postListByClassFromUser.value.length,
                      itemBuilder: (_, index) {
                        return PostHomeCardWidget(
                            snap: controller
                                .postListByClassFromUser.value[index]);
                      },
                    ),
                  );
                }
              }),
        ),
      ],
    );
  }
}

bool onNotification(ScrollEndNotification position) {
  PostHomeWidgetController postHomeWidgetController = Get.find();

  if (position.metrics.pixels > 0 && position.metrics.atEdge) {
    postHomeWidgetController.setUpdateNavPosition(true);
  } else {
    postHomeWidgetController.setUpdateNavPosition(false);
  }
  return true;
}
