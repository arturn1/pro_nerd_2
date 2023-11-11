import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/constants.dart';
import '../post_controller.dart';

class CustomDeleteDialog {
  CustomDeleteDialog({ required this.context});

  final BuildContext context;

  PostPageController postPageController = Get.find();

  buildDeleteConfirmation(String id) {
    return Get.defaultDialog(
        title: "Deseja realmente excluir este Post?",
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
        onPressed: () => {
              postPageController.deletePost(id),
              Get.back(),
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
          left: kMarginDefault * 5.5, right: kMarginDefault / 2),
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
