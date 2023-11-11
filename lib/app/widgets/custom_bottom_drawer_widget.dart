import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../core/utils/enums.dart';
import '../../modules/base_module/base_controller.dart';

class AnimatedBottomDrawer extends GetView<BaseController> {
  const AnimatedBottomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => NavigationBar(
        selectedIndex: controller.page,
        //onDestinationSelected: controller.animateTo,
        onDestinationSelected: (v) => controller.setPage(pagesEnum.values[v]),
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              size: Theme.of(context).iconTheme.size,
            ),
            label: "Home",
            selectedIcon: Icon(
              Icons.home,
              size: Theme.of(context).iconTheme.size,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: NavigationDestination(
              icon: Icon(
                Icons.image_outlined,
                size: Theme.of(context).iconTheme.size,
              ),
              label: "Posts",
              selectedIcon: Icon(
                Icons.image,
                size: Theme.of(context).iconTheme.size,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: NavigationDestination(
              icon: Icon(
                Icons.task_outlined,
                size: Theme.of(context).iconTheme.size,
              ),
              label: "Tarefas",
              selectedIcon: Icon(
                Icons.task,
                size: Theme.of(context).iconTheme.size,
              ),
            ),
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person_outline,
              size: Theme.of(context).iconTheme.size,
            ),
            label: "Profile",
            selectedIcon: Icon(
              Icons.person,
              size: Theme.of(context).iconTheme.size,
            ),
          ),
        ],
      ),
    );
  }
}
