import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/data/room.dart';
import '../../../../core/utils/verify_data.dart';
import '../../../../routes/pages.dart';
import '../../class_room_controller.dart';
import '../class_room_post_widget/class_room_post_widget_controller.dart';
import '../class_room_task_widget/class_room_task_widget_controller.dart';

class CustomSliverHeaderPosts extends GetView<ClassRoomPageController> {
  const CustomSliverHeaderPosts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: DelegateCustomSliverHeaderPosts(),
    );
  }
}

class DelegateCustomSliverHeaderPosts extends SliverPersistentHeaderDelegate {
  DelegateCustomSliverHeaderPosts();

  ClassRoomPageController controller = Get.find();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 40,
            width: Get.width * 0.75,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: Center(
              child: Text(
                'Posts',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inverseSurface,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Obx(
            () => AnimatedCrossFade(
              duration: const Duration(milliseconds: 500),
              firstChild: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                  ),
                ),
                  onPressed: () => controller.setDual(),
                  child: Icon(Icons.account_tree_outlined,
                  color: Theme.of(context).colorScheme.onTertiary,)),
              secondChild: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                  onPressed: () => controller.setDual(),
                  child: Icon(Icons.account_tree,
                  color: Theme.of(context).colorScheme.onTertiary)),
              crossFadeState: controller.isDual.value
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent =>58;

  @override
  double get minExtent => 58;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class CustomSliverHeaderRoomNameAndUserList extends StatelessWidget {
  final RoomModel roomModel;

  const CustomSliverHeaderRoomNameAndUserList(
      {Key? key, required this.roomModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      floating: true,
      delegate: DelegateCustomSliverHeaderRoomNameAndUserList(roomModel),
    );
  }
}

class DelegateCustomSliverHeaderRoomNameAndUserList
    extends SliverPersistentHeaderDelegate {
  final RoomModel roomModel;

  DelegateCustomSliverHeaderRoomNameAndUserList(this.roomModel);

  final ClassRoomPageController controller = Get.find();
  ClassRoomTaskWidgetController classRoomTaskWidgetController = Get.find();
  ClassRoomPostWidgetController classRoomPostWidgetController = Get.find();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.inversePrimary,
                blurRadius: 15,
                spreadRadius: 15,
                offset: const Offset(
                  -0,
                  -30,
                ),
              ),
            ],
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          height: 70,
          width: double.infinity,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          roomModel.name,
                          style: TextStyle(
                            fontSize: 25,
                            letterSpacing: .01,
                            color: Theme.of(context).colorScheme.inverseSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        roomModel.isPrivate
                            ? InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    Icons.lock,
                                    size: 20,
                                    color:
                                        Theme.of(context).colorScheme.inverseSurface,
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    Icons.lock_open,
                                    size: 20,
                                    color:
                                        Theme.of(context).colorScheme.inverseSurface,
                                  ),
                                ),
                              ),
                      ],
                    ),
                    Text(
                      '#${roomModel.classId.substring(0, 7)}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Obx(
                    () => AnimatedCrossFade(
                    crossFadeState: controller.isSearchingClassRoomScreenFilter.isFalse
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: GestureDetector(
                      onTap: () {
                        DatePickerHelper.instance
                            .postDateFilter(context)
                            .then((value) {
                          classRoomTaskWidgetController.runTaskFilter(value);
                          classRoomPostWidgetController.runPostFilter(value);
                        });
                        controller
                            .setIsSearchingClassRoomScreenFilter();
                      },
                      child: Icon(
                        Icons.filter_alt_rounded,
                        size: 25,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                    duration: const Duration(milliseconds: 200),
                    secondChild: GestureDetector(
                      onTap: () {
                        controller.resetFilter();
                        controller
                            .setIsSearchingClassRoomScreenFilter();
                      },
                      child: Icon(
                        Icons.filter_alt_off_outlined,
                        size: 25,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                  icon: Icon(
                    Icons.person_search,
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
                  iconSize: 30,
                  onPressed: () =>
                      Get.toNamed(Routes.usersList, arguments: roomModel),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
