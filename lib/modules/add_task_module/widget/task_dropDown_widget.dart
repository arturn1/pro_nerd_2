import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/data/room.dart';
import '../add_task_controller.dart';


class TaskDropDownWidget extends GetView<AddTaskPageController> {
  const TaskDropDownWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => DropdownButtonHideUnderline(
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: DropdownButton(
              isExpanded: true,
              isDense: true,
              icon: const Icon(Icons.keyboard_arrow_down),
              hint: Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Obx(() => controller.className == ''
                      ? const Text("Selecione um grupo")
                      : Text(controller.className))),
              items: controller.classes.map((RoomModel item) {
                return DropdownMenuItem(
                  value: item.classId,
                  child: Text(item.name),
                  onTap: () => controller.setClassName(item.name),
                );
              }).toList(),
              onChanged: (v) {
                controller.setClassId(v.toString());
              }),
        )),
    );

  }
}
