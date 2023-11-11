import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cam/modules/task_module/task_controller.dart';
import 'package:cam/modules/task_module/widget/task_page_fav_tab/task_page_fav_tab_widget.dart';
import 'package:cam/modules/task_module/widget/task_page_finished_tab/task_page_finished_tab_widget.dart';
import 'package:cam/modules/task_module/widget/task_page_header_search_widget.dart';
import 'package:cam/modules/task_module/widget/task_page_wait_tab/task_page_wait_tab_widget.dart';

import '../../core/values/constants.dart';

class TaskPage extends GetView<TaskPageController> {
  const TaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Get.lazyPut<TaskPageController>(() => TaskPageController());

    return Column(
      children: [
        const TaskPageHeaderSearchWidget(),
        Expanded(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                color: Theme.of(context).colorScheme.secondaryContainer,
                child: TabBar(
                  labelColor: Theme.of(context).colorScheme.onSecondaryContainer,
                  controller: controller.tabController,
                  tabs: const <Tab>[
                    Tab(text: 'Favoritos'),
                    Tab(text: 'Pendentes'),
                    Tab(text: 'Concluidas'),
                  ],
                ),
              ),

              Expanded(
                child: TabBarView(
                    controller: controller.tabController,
                    children: const [
                      TaskListFavTabWidget(),
                      TaskListWaitTabWidget(),
                      TaskListFinishedTabWidget()
                    ]),
              )

              //CustomTaskList()
            ])),
      ],
    );

  }
}
