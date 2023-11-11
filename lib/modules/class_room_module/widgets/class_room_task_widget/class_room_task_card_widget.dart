import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/data/task.dart';
import '../../../../core/utils/verify_data.dart';
import '../../../../core/values/constants.dart';

class ClassRoomTasksCardWidget extends StatelessWidget {
  const ClassRoomTasksCardWidget(
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
                width: Get.size <= const Size(1024, 1000)
                    ? Get.width / 2
                    : pixelDevice <= 2
                        ? Get.width / 8
                        : Get.width,
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
                                fontSize: 16,
                                color: CARD_TEXT,
                                fontWeight: FontWeight.bold,
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
                                fontSize: pixelDevice == 3
                                    ? Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.fontSize
                                    : Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.fontSize,
                              ),
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
