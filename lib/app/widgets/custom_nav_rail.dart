import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../core/utils/enums.dart';

import '../../modules/base_module/base_controller.dart';

class CustomNavigationRail extends GetView<BaseController> {
  const CustomNavigationRail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BaseController userController = Get.find();

    return Obx(() => NavigationRail(
        minWidth: 115,
        groupAlignment: -0.65,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        onDestinationSelected: (v) => controller.setPage(pagesEnum.values[v]),
        labelType: NavigationRailLabelType.selected,
        selectedLabelTextStyle: const TextStyle(
          color: Colors.black54,
        ),
        unselectedLabelTextStyle: const TextStyle(),
        destinations: const <NavigationRailDestination>[
          NavigationRailDestination(
            icon: Icon(Icons.house),
            label: Text(
              'Home',
              style: TextStyle(height: 2),
            ),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.image),
            label: Text(
              'Posts',
              style: TextStyle(height: 2),
            ),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.task),
            label: Text(
              'Tarefas',
              style: TextStyle(height: 2),
            ),
          ),
        ],
        selectedIndex: controller.page));
  }
}
