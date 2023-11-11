import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


import '../../app/data/room.dart';
import '../../app/widgets/custom_button_widget.dart';
import '../../app/widgets/custom_input_form_widget.dart';
import '../../core/values/constants.dart';
import 'add_class_room_controller.dart';

class EditClassRoomBottomSheetPage extends GetView<AddClassRoomController> {
  const EditClassRoomBottomSheetPage({required this.message,
    required this.snap,
    Key? key})
      : super(key: key);

  final RoomModel snap;
  final String message;

  @override
  Widget build(BuildContext context) {
    Get.put(AddClassRoomController());

    return SingleChildScrollView(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          color: Theme.of(context).colorScheme.surface,
          child: Form(
            //key: controller.formKey,
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(15),
                      ],
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (v) => controller.setName(v),
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      decoration: InputDecoration(
                          labelText: snap.name,
                          hintMaxLines: 1,
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green, width: 4.0))),
                    ),
                  ),
                  Obx(
                    () => CheckboxListTile(
                      title: const Text('Privado'),
                      value: controller.isPrivate.value,
                      onChanged: (value) {
                        controller.isPrivate.value =
                            !controller.isPrivate.value;
                      },
                    ),
                  ),
                  if (controller.isPrivate.isTrue)
                    FormInputWidget(
                        controller: (v) => controller.setPassword(v),
                        icon: Icons.lock,
                        title: 'Nova senha',
                        validator: (v) => controller.getEmptyError(v)),
                  const SizedBox(height: 20),
                  CustomButtonWidget(
                      text: 'Salvar',
                      function: () => controller.canCreate()
                          ? controller.editClass(snap.classId).then((value) => Get.back())
                          : controller.messageError())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
