import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../app/data/task.dart';
import '../../../../app/data/user.dart';
import '../../../../core/values/constants.dart';

mixin TaskHomeWidgetService {
  Stream<List<TaskModel>> getTaskClassByUser(List<dynamic> classes) {
    return firestore.collection("tasks").snapshots().map((QuerySnapshot query) {
      List<TaskModel> retVal = [];
      for (var element in query.docs) {
        var taskModel = (TaskModel.fromSnap(element));
        for (var f in classes) {
          if (f == taskModel.classId) {
            retVal.add(taskModel);
          }
        }
      }
      retVal.sort((a, b) => a.finalDate.compareTo(b.finalDate));
      return retVal;
    });
  }

  Future<List<TaskModel>> getTaskClass(List<dynamic> classes) {
    return firestore.collection("tasks").get().then((QuerySnapshot query) {
      List<TaskModel> retVal = [];
      for (var element in query.docs) {
        var taskModel = (TaskModel.fromSnap(element));
        var classId = (TaskModel.fromSnap(element)).classId;
        for (var f in classes) {
          if (f == classId) {
            retVal.add(taskModel);
          }
        }
      }
      retVal.sort((a, b) => a.finalDate.compareTo(b.finalDate));
      return retVal;
    });
  }

  Stream<List<UserTaskStatusViewModel>> getStatusStream(
      uid) {
    return firestore
        .collection("taskUserStatus")
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserTaskStatusViewModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(UserTaskStatusViewModel.fromSnap(element));
      }
      return retVal;
    });
  }

  }