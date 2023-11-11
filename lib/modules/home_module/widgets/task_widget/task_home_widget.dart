import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cam/modules/home_module/widgets/task_widget/task_home_widget_controller.dart';


import '../../../../app/data/task.dart';
import '../../../../core/values/constants.dart';
import '../../../base_module/base_controller.dart';
import 'task_home_card_widget.dart';

class TaskHomeWidget extends GetView<TaskHomeWidgetController> {
  const TaskHomeWidget({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Text(
            'Próximas entregas',
            style: TextStyle(
              fontSize: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.fontSize,
            ),
          ),
        ),
        GetX<TaskHomeWidgetController>(
            init: Get.put(TaskHomeWidgetController()),
            builder: (TaskHomeWidgetController controller) {
              return SizedBox(
                width: double.infinity,
                height: 110,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: controller.getWaitList().isEmpty
                      ? 1
                      : controller.getWaitList().length,
                  itemBuilder: (_, index) {
                    final int count = controller.getWaitList().isEmpty
                        ? 1
                        : controller.getWaitList().length;

                    final Animation<double> animation =
                    Tween<double>(begin: 0.0, end: 1.0)
                        .animate(CurvedAnimation(
                        parent: controller.animationController,
                        curve: Interval(
                          (1 / count) * index,
                          1.0,
                          curve: Curves.fastOutSlowIn,
                        )));

                    controller.animationController.forward();

                    return controller.getWaitList().isEmpty
                        ? SizedBox(
                      width: 230,
                      height: 100,
                          child: NextDeliveriesCard(
                          animation: animation,
                          animationController:
                          controller.animationController,
                          taskModel: TaskModel(
                              finalDate: DateTime.now(),
                              description: 'Seja bem vindo!',
                              taskId: '',
                              classId: '',
                              className: 'Novo por aqui?!')),
                        )
                        : SizedBox(
                        width: 230,
                        height: 100,
                        child: NextDeliveriesCard(
                            animation: animation,
                            animationController:
                            controller.animationController,
                            taskModel: controller.getWaitList()[index]));
                  },
                ),
              );
            }),
      ],
    );
  }
}
