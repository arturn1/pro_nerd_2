import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../app/widgets/custom_bottom_bar.dart';
import '../../app/widgets/custom_button_widget.dart';
import '../../app/widgets/custom_snack_bar_widget.dart';
import '../../core/utils/verify_data.dart';
import 'widget/task_dropDown_widget.dart';
import 'add_task_controller.dart';

class TaskBottomSheetPage extends GetView<AddTaskPageController> {
  const TaskBottomSheetPage({this.message, Key? key})
      : super(key: key);

  final String? message;

  @override
  Widget build(BuildContext context) {
    Get.put(AddTaskPageController());

    return SingleChildScrollView(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          color: Theme.of(context).colorScheme.surface,
          child: Form(
            //key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CustomBottomBar(),
                const SizedBox(
                  height: 15.0,
                ),
                const TaskDropDownWidget(),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 60,
                  child: TextFormField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(80),
                    ],
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (v) => controller.setDescription(v),
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    decoration: const InputDecoration(
                        labelText: 'Descrição',
                        //hintMaxLines: 1,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 4.0))),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    onTap: () => DatePickerHelper.instance.presentDatePicker(context),
                    controller: DatePickerHelper.instance.textController,
                    //initialValue: dateController.showDateNow(),
                    keyboardType: TextInputType.datetime,
                    maxLines: 1,
                    decoration: InputDecoration(
                        prefixIcon: IconButton(
                          onPressed: () =>
                              DatePickerHelper.instance.presentDatePicker(context),
                          icon: const Icon(Icons.date_range),
                        ),
                        labelText: 'Data de Entrega',
                        hintMaxLines: 1,
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(width: 4.0))),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                CustomButtonWidget(
                  text: 'Salvar',
                  function: () => controller.className.isNotEmpty
                      ? controller.addTask().then((value) => Get.back())
                      : CustomSnack().buildCardError('Selecione um grupo'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
