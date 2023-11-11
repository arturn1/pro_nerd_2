import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../app/data/task.dart';
import '../../../../core/values/constants.dart';

mixin class ClassRoomTaskWidgetService {
  Stream<List<TaskModel>> getTaskStreamByClass(String classId) {
    return firestore
        .collection("tasks")
        .where('classId', isEqualTo: classId)
        .orderBy("finalDate")
        .snapshots()
        .map((QuerySnapshot query) {
      List<TaskModel> retVal = [];
      for (var element in query.docs) {
        if (!TaskModel.fromSnap(element)
            .finalDate
            .difference(DateTime.now())
            .inDays
            .isNegative) {
          retVal.add(TaskModel.fromSnap(element));
        }
      }
      return retVal;
    });
  }

  Future<List<TaskModel>> getTaskClass(String classId) {
    return firestore.collection("tasks").get().then((QuerySnapshot query) {
      List<TaskModel> retVal = [];
      for (var element in query.docs) {
        var taskModel = (TaskModel.fromSnap(element));
          if (classId == taskModel.classId) {
            retVal.add(taskModel);
          }
      }
      retVal.sort((a, b) => a.finalDate.compareTo(b.finalDate));
      return retVal;
    });
  }

}
