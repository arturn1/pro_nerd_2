import 'package:cloud_firestore/cloud_firestore.dart';
import '../../app/data/task.dart';
import '../../app/data/user.dart';
import '../../core/values/constants.dart';


mixin class TaskService {
  Future<void> addTaskToDB(TaskModel taskModel) async {
    try {
      await firestore.collection("tasks").doc(taskModel.taskId).set({
        'taskId': taskModel.taskId,
        'classId': taskModel.classId,
        'className': taskModel.className,
        'description': taskModel.description,
        'finalDate': taskModel.finalDate,
        'datePublished': taskModel.datePublished,
        'isDone': taskModel.isDone
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editStatusTaskToDB(
      UserTaskStatusViewModel userTaskStatusViewModel) async {
    try {
      await firestore
          .collection("taskUserStatus")
          .doc('${userTaskStatusViewModel.taskId}-${userTaskStatusViewModel.uid}')
          .set({
        'taskId': userTaskStatusViewModel.taskId,
        'uid': userTaskStatusViewModel.uid,
        'status': userTaskStatusViewModel.status,
      });

      await firestore
          .collection("tasks")
          .doc(userTaskStatusViewModel.taskId)
          .update({'isDone': true});
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<TaskModel>> getTaskStreamFromDB() {
    return firestore
        .collection("tasks")
        .orderBy("finalDate")
        .snapshots()
        .map((QuerySnapshot query) {
      List<TaskModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(TaskModel.fromSnap(element));
      }
      return retVal;
    });
  }

  Stream<List<TaskModel>> getTaskStreamByClassFromDB(String classId) {
    return firestore
        .collection("tasks")
        .where('classId', isEqualTo: classId)
        .orderBy("finalDate")
        .snapshots()
        .map((QuerySnapshot query) {
      List<TaskModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(TaskModel.fromSnap(element));
      }
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

  Stream<List<TaskModel>> listTaskByClassFromUserFromDB(UserModel? user)  {
    return firestore
        .collection("tasks")
        .snapshots()
        .map((QuerySnapshot query) {
      List<TaskModel> retVal = [];
      for (var element in query.docs) {
        var taskModel = (TaskModel.fromSnap(element));
        for (var c in user!.classes) {
          if (c == taskModel.classId) {
            retVal.add(taskModel);
          }
        }
      }
      retVal.sort((a, b) => a.finalDate.compareTo(b.finalDate));
      return retVal.reversed.toList();
    });
  }

  Future<void> deleteTaskFromDB(String taskId) async {
    try {
      await firestore.collection('tasks').doc(taskId).delete();
    } catch (err) {
      rethrow;
    }
  }

}
