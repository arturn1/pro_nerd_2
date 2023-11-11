import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../../../core/values/constants.dart';
import '../task_confirm_delete_widget.dart';
import '../task_page_card_widget.dart';
import 'task_page_fav_tab_controller.dart';

class TaskListFavTabWidget extends GetView<TaskPageFavTabController> {
  const TaskListFavTabWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<TaskPageFavTabController>(
        init: Get.put<TaskPageFavTabController>(TaskPageFavTabController()),
        builder: (TaskPageFavTabController controller) {
          if (controller.getFavList().isEmpty) {
            return Container(
                padding: const EdgeInsets.all(kPaddingDefault),
                child: const Column(
                  children: [
                    Text("Não há tarefas favoritadas"),
                  ],
                ));
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: controller.getFavList().length,
              itemBuilder: (_, index) {
                return Slidable(
                  key: UniqueKey(),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (_) => CustomDeleteDialog(context: context)
                            .buildCompleteConfirmation(
                                controller.getFavList()[index].taskId),
                        backgroundColor: kSuccessColorContainer90,
                        foregroundColor: kSuccessColor40,
                        icon: Icons.verified,
                        label: 'Entregue',
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (_) => controller.taskPageController
                            .editStatusTask(
                                controller.getFavList()[index].taskId, 'wait'),
                        backgroundColor: kSecondaryColorContainer90,
                        foregroundColor: kOnSecondaryColorContainer10,
                        icon: Icons.star_half,
                        label: 'Desfavoritar',
                      ),
                    ],
                  ),
                  child: TaskPageCardWidget(
                      taskModel: controller.getFavList()[index]),
                );
              },
            );
          }
        });
  }
}
