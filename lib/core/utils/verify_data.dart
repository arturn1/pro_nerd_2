import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../../app/data/task.dart';
import '../../modules/post_module/post_controller.dart';

class DatePickerHelper extends GetxController {
  PostPageController postController = Get.put(PostPageController());
  // ClassRoomPageController classController = Get.put(ClassRoomPageController());

  //Rxn<DateTime> myDate = Rxn<DateTime>();
  DatePickerHelper._();

  static final DatePickerHelper instance = DatePickerHelper._();

  Rx<DateTime> myDate = DateTime.now().obs;
  Rx<DateTime>? pickedDate = DateTime.now().obs;

  TextEditingController textController = TextEditingController();

  setDate(DateTime value) => pickedDate!.value = value;

  presentDatePicker(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        locale: const Locale('pt', 'BR'),
        context: context,
        initialDate: myDate.value,
        firstDate: DateTime(2020),
        lastDate: DateTime(2024));
    // Check if no date is selected
    if (selected == null) {
      return;
    }
    textController.text = showCorrectDate(selected);
    setDate(selected);
  }

  Future<DateTime?> postDateFilter(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: myDate.value,
        firstDate: DateTime(2020),
        lastDate: DateTime(2024));
    // Check if no date is selected
    if (selected == null) {
      postController.setIsSearchingPostScreenFilterFalse();
      //classController.setIsSearchingClassRoomScreenFilterFalse();
      postController.resetFilter();
      //classController.resetFilter();
      return null;
    }
    return selected;
  }

  DateTime get selectedDate => pickedDate!.value;

  showDateNow() {
    return "${myDate.value.day}/${myDate.value.month}/${myDate.value.year}";
  }

  showCorrectDate(DateTime d) {
    return "${d.day}/${d.month}/${d.year}";
  }

  showDateLikeInsta(DateTime d) {
    return Jiffy(d).format('d MMM');
  }

  String getDate(TaskModel taskModel) {
    if (taskModel.finalDate.difference(DateTime.now()).inDays == 0) {
      return taskModel.finalDate.day == DateTime.now().day
          ? 'É hoje'
          : 'Amanhã';
    } else if (taskModel.finalDate.difference(DateTime.now()).inDays == 1) {
      return "Depois de amanhã";
    } else if (taskModel.finalDate.difference(DateTime.now()).inDays < 1) {
      return taskModel.finalDate.difference(DateTime.now()).inDays == -1
          ? "Atrasado ${taskModel.finalDate.difference(DateTime.now()).inDays.toString().substring(1, 2)} dia"
          : "Atrasado ${taskModel.finalDate.difference(DateTime.now()).inDays.toString().substring(1, 2)} dias";
    } else {
      return "Faltam ${taskModel.finalDate.difference(DateTime.now()).inDays} dias";
    }
  }

  int getOnlyDate(DateTime finalDate) {
    return finalDate.difference(DateTime.now()).inDays.isNegative
        ? 0
        : finalDate.difference(DateTime.now()).inDays;
  }
}
