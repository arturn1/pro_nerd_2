import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cam/modules/class_room_module/widgets/class_room_header/custom_class_room_header.dart';
import 'package:cam/modules/class_room_module/widgets/class_room_post_widget/class_room_post_widget.dart';
import 'package:cam/modules/class_room_module/widgets/class_room_task_widget/class_room_task_widget.dart';

import '../../app/data/room.dart';
import '../../routes/pages.dart';
import 'class_room_controller.dart';

class ClassRoomPage extends GetView<ClassRoomPageController> {
  ClassRoomPage({Key? key}) : super(key: key);

  final RoomModel roomModel = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                elevation: 0,
                automaticallyImplyLeading: false,
                flexibleSpace: AppBar(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  title: const Text('PRO NERD'),
                  centerTitle: true,

                ),
                collapsedHeight: 60,
                expandedHeight: 60,
              ),
              CustomSliverHeaderRoomNameAndUserList(roomModel: roomModel),
              SliverToBoxAdapter(
                  child: Obx(
                () => Container(
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
                  child: AnimatedCrossFade(
                    duration: const Duration(milliseconds: 300),
                    sizeCurve: Curves.linear,
                    crossFadeState: controller.isFollowing.isTrue
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: customFollowingButton(context),
                    secondChild: customFollowButton(context),
                  ),
                ),
              )),
              SliverList(
                delegate: SliverChildListDelegate([
                  const ClassRoomTasksWidget(),
                ]),
              ),
              const CustomSliverHeaderPosts(),
              const ClassRoomPostWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Container customFollowButton(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.inversePrimary,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Center(
          child: ElevatedButton(
            onPressed: () => controller.followClass(roomModel.classId),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              minimumSize: const Size(350, 37),
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              // elevation: 2,
              padding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            child: Text(
              'Seguir',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onTertiary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container customFollowingButton(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.inversePrimary,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: () => Get.toNamed(Routes.chat,
                    arguments: [roomModel, controller.isFollowing.value]),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.tertiary,
                  minimumSize: const Size(110, 37),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  // elevation: 2,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Icon(
                        Icons.chat,
                        color:
                            Theme.of(context).colorScheme.onTertiary,
                      ),
                    ),
                    Text(
                      'Chat',
                      style: TextStyle(
                        color:
                            Theme.of(context).colorScheme.onTertiary,
                      ),
                    ),
                  ],
                )),
            OutlinedButton(
                onPressed: () => controller.followClass(roomModel.classId),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 37),
                  backgroundColor:
                      Theme.of(context).colorScheme.inversePrimary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  // elevation: 2,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  side: const BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Icon(
                        Icons.group_off_outlined,
                        color:
                            Theme.of(context).colorScheme.onTertiaryContainer,
                      ),
                    ),
                    Text(
                      'Deixar de seguir',
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onTertiaryContainer),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
