import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/values/constants.dart';
import '../task_page_card_widget.dart';
import 'task_page_finished_tab_controller.dart';

class TaskListFinishedTabWidget extends StatelessWidget {
  const TaskListFinishedTabWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<TaskPageFinishedTabController>(
        init: Get.put<TaskPageFinishedTabController>(TaskPageFinishedTabController()),
        builder: (TaskPageFinishedTabController taskController) {
          if (taskController.getFinishedList().isEmpty) {
            return Container(
                padding: const EdgeInsets.all(kPaddingDefault),
                child: const Column(
                  children: [
                    Text("Você ainda não concluiu nenhuma tarefa..."),
                  ],
                ));
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: taskController.getFinishedList().length,
              itemBuilder: (_, index) {
                return TaskPageCardWidget(
                    taskModel: taskController.getFinishedList()[index]);
              },
            );
          }
        });
  }
}
