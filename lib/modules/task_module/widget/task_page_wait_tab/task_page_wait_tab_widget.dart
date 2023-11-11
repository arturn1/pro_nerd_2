import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:cam/modules/task_module/widget/task_page_wait_tab/task_page_wait_tab_controller.dart';

import '../../../../core/values/constants.dart';
import '../task_confirm_delete_widget.dart';
import '../task_page_card_widget.dart';

class TaskListWaitTabWidget extends StatelessWidget {
  const TaskListWaitTabWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<TaskPageWaitTabController>(
        init: Get.put<TaskPageWaitTabController>(TaskPageWaitTabController()),
        builder: (TaskPageWaitTabController controller) {
          if (controller.getWaitList().isEmpty) {
            return Container(
                padding: const EdgeInsets.all(kPaddingDefault),
                child: const Column(
                  children: [
                    Text("Não há tarefas pendentes"),
                  ],
                ));
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: controller.getWaitList().length,
              itemBuilder: (_, index) {
                return Slidable(
                  key: UniqueKey(),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (_) => CustomDeleteDialog(context: context)
                            .buildCompleteConfirmation(
                                controller.getWaitList()[index].taskId),
                        backgroundColor: kSuccessColorContainer90,
                        foregroundColor: kSuccessColor40,
                        icon: Icons.verified,
                        label: 'Entregue',
                      ),
                      SlidableAction(
                        onPressed: (_) => controller.taskPageController
                            .editStatusTask(
                                controller.getWaitList()[index].taskId, 'fav'),
                        backgroundColor: kSecondaryColorContainer90,
                        foregroundColor: kOnSecondaryColorContainer10,
                        icon: Icons.star,
                        label: 'Favorito',
                      ),
                    ],
                  ),
                  child: TaskPageCardWidget(
                      taskModel: controller.getWaitList()[index]),
                );
              },
            );
          }
        });
  }
}
