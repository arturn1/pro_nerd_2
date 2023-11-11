import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cam/modules/home_module/widgets/task_widget/task_home_widget_controller.dart';

import '../../../../app/data/task.dart';
import '../../../../core/utils/verify_data.dart';


class NextDeliveriesCard extends GetView<TaskHomeWidgetController> {
  const NextDeliveriesCard(
      {Key? key,
      required this.animationController,
      required this.animation,
      required this.taskModel})
      : super(key: key);

  final TaskModel taskModel;
  final AnimationController animationController;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    var CARD_COLOR = Theme.of(context).colorScheme.primaryContainer;
    var CARD_TEXT = Theme.of(context).colorScheme.onPrimaryContainer;

    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, _) {
          return FadeTransition(
            opacity: animation,
            child: Transform(
              transform: Matrix4.translationValues(
                  100 * (1.0 - animation.value), 0.0, 0.0),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: 160,
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: CARD_COLOR,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              taskModel.className,
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.fontSize,
                                color: CARD_TEXT,
                              ),
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              taskModel.description.length > 30
                                  ? "${taskModel.description.substring(0, 30)}..."
                                  : taskModel.description,
                              style: (TextStyle(
                                color: CARD_TEXT,
                                fontWeight: FontWeight.bold,
                              )),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              DatePickerHelper.instance.getDate(taskModel),
                              style: TextStyle(
                                  color: CARD_TEXT,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.fontSize),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
