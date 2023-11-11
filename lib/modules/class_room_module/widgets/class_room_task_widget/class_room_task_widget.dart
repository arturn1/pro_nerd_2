import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/data/task.dart';
import '../../class_room_controller.dart';
import 'class_room_task_card_widget.dart';

class ClassRoomTasksWidget extends GetView<ClassRoomPageController> {
  const ClassRoomTasksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return SizedBox(
      height: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    blurRadius: 15,
                    spreadRadius: 15,
                    offset: const Offset(
                      -0,
                      -30,
                    ),
                  ),
                ],
                color: Theme.of(context).colorScheme.secondaryContainer),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    blurRadius: 15,
                    spreadRadius: 15,
                    offset: const Offset(
                      0,
                      -30,
                    ),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    'Entregas',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface),
                  ),
                  const Spacer(),

                ],
              ),
            ),
          ),
          GetX<ClassRoomPageController>(
              init: Get.put<ClassRoomPageController>(ClassRoomPageController()),
              builder: (ClassRoomPageController controller) {
                return SizedBox(
                  width: double.infinity,
                  height: 110,
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: controller.classRoomTaskWidgetController
                            .filteredTaskList.value.isEmpty
                        ? 1
                        : controller.classRoomTaskWidgetController
                            .filteredTaskList.value.length,
                    itemBuilder: (_, index) {
                      final int count = controller.classRoomTaskWidgetController
                              .filteredTaskList.value.isEmpty
                          ? 1
                          : controller.classRoomTaskWidgetController
                              .filteredTaskList.value.length;

                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: controller
                                      .classRoomTaskWidgetController
                                      .animationController,
                                  curve: Interval(
                                    (1 / count) * index,
                                    1.0,
                                    curve: Curves.fastOutSlowIn,
                                  )));
                      controller
                          .classRoomTaskWidgetController.animationController
                          .forward();
                      return controller.classRoomTaskWidgetController
                              .filteredTaskList.value.isEmpty
                          ? ClassRoomTasksCardWidget(
                              taskModel: TaskModel(
                                  finalDate: DateTime.now(),
                                  description: 'Seja bem vindo',
                                  taskId: '',
                                  classId: '',
                                  className: 'Novo por aqui?!'),
                              animation: animation,
                              animationController: controller
                                  .classRoomTaskWidgetController
                                  .animationController,
                            )
                          : ClassRoomTasksCardWidget(
                              taskModel: controller
                                  .classRoomTaskWidgetController
                                  .filteredTaskList
                                  .value[index],
                              animation: animation,
                              animationController: controller
                                  .classRoomTaskWidgetController
                                  .animationController,
                            );
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}
