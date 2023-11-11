import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/constants.dart';
import '../task_controller.dart';

class CustomDeleteDialog {
  CustomDeleteDialog({Key? key, required this.context});

  final BuildContext context;

  TaskPageController taskPageController = Get.find();

  buildDeleteConfirmation(String id) {
    Get.defaultDialog(
        title: "Deseja realmente deletar esta tarefa?",
        titleStyle: TextStyle(fontSize: 15,
            color: Theme.of(context).colorScheme.onSurface),
        content: getContent(id),
        titlePadding: const EdgeInsets.fromLTRB(kPaddingDefault,
            kPaddingDefault * 1.5, kPaddingDefault, kPaddingDefault),
        barrierDismissible: false,
        radius: 15.0,
        backgroundColor: Theme.of(context).colorScheme.surface,);
  }

  buildCompleteConfirmation(String id) {
    Get.defaultDialog(
        title: "Deseja realmente completar esta tarefa?",
        titleStyle: TextStyle(fontSize: 15,
            color: Theme.of(context).colorScheme.onSurface),
        content: getContent(id),
        titlePadding: const EdgeInsets.fromLTRB(kPaddingDefault,
            kPaddingDefault * 1.5, kPaddingDefault, kPaddingDefault),
        barrierDismissible: false,
        radius: 15.0,
        backgroundColor: Theme.of(context).colorScheme.surface,);
  }

  Widget getContent(id) {
    return Row(children: [cancelBtn(), confirmBtn(id)]);
  }

  Widget confirmBtn(String id) {
    return TextButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        onPressed: () {
          taskPageController.editStatusTask(id, 'finished');
          Get.back();
        },
        child: Text(
          "Sim",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ));
  }

  Widget cancelBtn() {
    return Container(
      margin: const EdgeInsets.only(
          left: kMarginDefault * 6, right: kMarginDefault / 2),
      child: TextButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () {
            Get.back();
          },
          child: Text(
            "Não",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          )),
    );
  }
}
