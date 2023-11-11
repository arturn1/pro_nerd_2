import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cam/modules/task_module/widget/task_page_finished_tab/task_page_finished_tab_controller.dart';
import 'package:cam/modules/task_module/widget/task_page_wait_tab/task_page_wait_tab_controller.dart';


import '../../../app/data/task.dart';
import '../../../core/utils/verify_data.dart';
import '../../../core/values/constants.dart';
import '../task_controller.dart';

class TaskPageCardWidget extends GetView<TaskPageController> {
  final TaskModel taskModel;

  const TaskPageCardWidget({Key? key, required this.taskModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    Color ICONS_COLOR = Theme.of(context).colorScheme.onSecondaryContainer;
    Color CARD_COLOR = Theme.of(context).colorScheme.secondaryContainer;
    Color DAYS_LABEL_COLOR = Theme.of(context).colorScheme.onSecondaryContainer;

    return Container(
      padding: const EdgeInsets.all(kPaddingExternalDefault / 2),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
              color: CARD_COLOR,
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(kPaddingDefault / 1.3),
          height: kHeightDefault * 0.20,
          width: kWidthDefault,
          child: Row(
            children: [
              FittedBox(
                child: Container(
                  margin: const EdgeInsets.only(right: kMarginDefault),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Faltam',
                        style: TextStyle(color: DAYS_LABEL_COLOR,
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.fontSize),
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          DatePickerHelper.instance
                              .getOnlyDate(taskModel.finalDate)
                              .toString(),
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.fontSize,
                            color: DAYS_LABEL_COLOR,
                          ),
                        ),
                      ),
                      Text(
                        'dias',
                        style: TextStyle(color: DAYS_LABEL_COLOR,
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.fontSize),
                      ),
                      Text(
                        DatePickerHelper.instance
                            .showCorrectDate(taskModel.finalDate),
                        style: TextStyle(color: DAYS_LABEL_COLOR,
                            fontSize: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.fontSize),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(children: [
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          constraints: const BoxConstraints(
                            minWidth: 150
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                          margin:
                              const EdgeInsets.only(bottom: kMarginDefault / 2),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              border:
                                  Border.all(color: kOnPrimaryColorContainer10),
                              borderRadius:
                                  BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          child: Text(
                            taskModel.className,
                            style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.fontSize,
                                color: Theme.of(context).colorScheme.onSurface,),
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (!TaskPageWaitTabController()
                              .getWaitFavList()
                              .contains(taskModel) &&
                          !TaskPageFinishedTabController()
                              .getFinishedList()
                              .contains(taskModel))
                        Container(
                            margin:
                                const EdgeInsets.only(bottom: 10, right: 10),
                            child: Icon(
                              Icons.star,
                              color: ICONS_COLOR,
                              size: Theme.of(context).iconTheme.size,
                            )),
                      if (TaskPageFinishedTabController()
                          .getFinishedList()
                          .contains(taskModel))
                        Container(
                            margin:
                                const EdgeInsets.only(bottom: 10, right: 10),
                            child: Icon(
                              Icons.verified,
                              color: ICONS_COLOR,
                              size: Theme.of(context).iconTheme.size,
                            )),
                      if (!TaskPageFinishedTabController()
                              .getFinishedList()
                              .contains(taskModel) &&
                          taskModel.finalDate
                              .difference(DateTime.now())
                              .inDays
                              .isNegative)
                        Container(
                            margin:
                                const EdgeInsets.only(bottom: 10, right: 10),
                            child: Icon(
                              Icons.lock_clock,
                              color: ICONS_COLOR,
                              size: Theme.of(context).iconTheme.size,
                            )),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(kPaddingDefault / 2),
                        child: Text(taskModel.description,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),),
                      ),
                    ),
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
