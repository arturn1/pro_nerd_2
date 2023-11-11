import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cam/modules/post_module/post_controller.dart';
import 'package:cam/modules/post_module/widget/post_card_widget.dart';


import '../../app/widgets/custom_header_widget.dart';
import '../../core/utils/verify_data.dart';
import '../../core/values/constants.dart';

class PostPage extends GetView<PostPageController> {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Center(child: CustomHeader(text: 'Posts')),
      Expanded(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).colorScheme.secondaryContainer,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Obx(
                    () => Text(
                        '${controller.filteredPostList.value.length} posts encontrados',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),),
                  ),
                  const Spacer(),
                  const SizedBox(
                    width: 10,
                  ),
                  Obx(
                    () => AnimatedCrossFade(
                      crossFadeState:
                          controller.isSearchingPostScreenFilter.isFalse
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                      firstChild: GestureDetector(
                        child: Icon(
                          Icons.date_range,
                          size: Theme.of(context).iconTheme.size,
                        ),
                        onTap: () {
                          DatePickerHelper.instance
                              .postDateFilter(context)
                              .then((value) => controller.runPostFilter(value));
                          controller.setIsSearchingPostScreenFilter();
                        },
                      ),
                      duration: const Duration(milliseconds: 200),
                      secondChild: GestureDetector(
                          child: Icon(
                            Icons.cancel_rounded,
                            size: Theme.of(context).iconTheme.size,
                          ),
                          onTap: () {
                            controller.setIsSearchingPostScreenFilter();
                            controller.resetFilter();
                          }),
                    ),
                  ),
                ],
              ),
            ),
            GetX<PostPageController>(
                init: Get.put<PostPageController>(PostPageController()),
                builder: (PostPageController controller) {
                  if (controller.filteredPostList.value.isEmpty) {
                    return Container(
                        padding: const EdgeInsets.all(kPaddingDefault * 2),
                        child: const Column(
                          children: [
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
                    return Expanded(
                      child: ListView.builder(
                        itemCount: controller.filteredPostList.value.length,
                        itemBuilder: (_, index) {
                          return PostCardWidget(
                              snap: controller.filteredPostList.value[index]);
                        },
                      ),
                    );
                  }
                }),
          ],
        ),
      )
    ]);
  }
}
