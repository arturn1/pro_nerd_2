import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/data/room.dart';
import '../../../app/widgets/custom_input_form_widget.dart';
import '../../../app/widgets/custom_snack_bar_widget.dart';
import '../../../core/values/constants.dart';
import '../../../routes/pages.dart';
import '../search_class_page_controller.dart';

class CustomPasswordDialog {
  CustomPasswordDialog({required this.context});

  final BuildContext context;
  SearchClassPageController searchClassPageController = Get.find();

  buildPasswordConfirmation(RoomModel roomModel) {
    Get.defaultDialog(
        title: "Grupo Privado",
        titleStyle: const TextStyle(fontSize: 15),
        content: _getContent(roomModel),
        titlePadding: const EdgeInsets.fromLTRB(
            kPaddingDefault / 2, kPaddingDefault * 1.5, kPaddingDefault, 0),
        barrierDismissible: false,
        radius: 10.0,
        backgroundColor: Theme.of(context).colorScheme.surface);
  }

  Widget _getContent(RoomModel roomModel) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: FormInputWidget(
              locked: true,
              controller: (v) => searchClassPageController.setPassword(v),
              icon: Icons.lock,
              title: 'Senha',
              validator: (v) => searchClassPageController.getEmptyError(v)),
        ),
        Row(children: [_cancelBtn(), _confirmBtn(roomModel)]),
      ],
    );
  }

  Widget _confirmBtn(RoomModel roomModel) {
    return Container(
      margin: const EdgeInsets.only(right: kMarginDefault / 2),
      child: TextButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ), backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () async => await searchClassPageController.checkPassword(
                  searchClassPageController.password, roomModel)
              ? {
                  searchClassPageController.reset(),
                  Get.back(),
                  Get.toNamed(
                    Routes.classRoom,
                    arguments: roomModel,
                  )
                }
              : {
            CustomSnack().buildPassInformation('Senha Incorreta')
          },
          child: Text(
            "Acessar",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          )),
    );
  }

  Widget _cancelBtn() {
    return Container(
      margin: const EdgeInsets.only(
          left: kMarginDefault * 6, right: kMarginDefault / 2),
      child: TextButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ), backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          onPressed: () {
            Get.back();
          },
          child: Text(
            "Cancelar",
            style: TextStyle(
              color: kOnPrimaryColorContainer10,
            ),
          )),
    );
  }
}
