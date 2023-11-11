import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


import '../../app/widgets/custom_bottom_bar.dart';
import '../../app/widgets/custom_button_widget.dart';
import '../../app/widgets/custom_input_form_widget.dart';
import '../../core/values/constants.dart';
import 'add_class_room_controller.dart';

class ClassRoomBottomSheetPage extends GetView<AddClassRoomController> {
  const ClassRoomBottomSheetPage({required this.message, Key? key})
      : super(key: key);

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
                  const CustomBottomBar(),
                  Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.fontSize,
                        fontWeight: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.fontWeight,
                      ),
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
                      decoration: const InputDecoration(
                          labelText: 'Nome',
                          hintMaxLines: 1,
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green, width: 4.0))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
                    child: Row(
                      children: [
                        Text(
                          "Privado",
                          style: TextStyle(fontSize: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.fontSize,),
                        ),
                        const Spacer(),
                        GFToggle(
                          enabledTrackColor: Theme.of(context).colorScheme.primary,
                          value: controller.isPrivate.value,
                          onChanged: (value) {
                            controller.isPrivate.value =
                                !controller.isPrivate.value;
                          },
                          type: GFToggleType.ios,
                        ),
                      ],
                    ),
                  ),
                  AnimatedCrossFade(
                    crossFadeState: controller.isPrivate.isTrue
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 300),
                    firstChild: FormInputWidget(
                        controller: (v) => controller.setPassword(v),
                        icon: Icons.lock,
                        title: 'Nova senha',
                        validator: (v) => controller.getEmptyError(v)),
                    secondChild: Container(),
                  ),
                  const SizedBox(height: 20),
                  CustomButtonWidget(
                      text: 'Salvar',
                      function: () => controller.canCreate()
                          ? controller.addClass().then((value) => Get.back())
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
