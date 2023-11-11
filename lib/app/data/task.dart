import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  late String taskId;
  late String classId;
  late String className;
  late String description;
  late DateTime finalDate;
  late DateTime? datePublished;
  late bool isDone;

  TaskModel(
      {required this.taskId,
      required this.classId,
      required this.className,
      required this.description,
      required this.finalDate,
      this.datePublished,
      this.isDone = false});

  static TaskModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return TaskModel(
        classId: snapshot["classId"],
        className: snapshot["className"],
        taskId: snapshot["taskId"],
        description: snapshot["description"],
        finalDate: snapshot["finalDate"].toDate(),
        datePublished: snapshot["datePublished"]?.toDate(),
        isDone: snapshot['isDone']);
  }

  Map<String, dynamic> toJson() => {
        "classId": classId,
        "className": className,
        "taskId": taskId,
        "description": description,
        "finalDate": finalDate,
        'datePublished': datePublished,
        "isDone": isDone
      };
}

class UserTaskStatusViewModel {
  late String uid;
  late String taskId;
  late String status;

  UserTaskStatusViewModel({
    this.uid = '',
    this.taskId = '',
    this.status = '',
  });

  static UserTaskStatusViewModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserTaskStatusViewModel(
      uid: snapshot["uid"],
      status: snapshot["status"],
      taskId: snapshot["taskId"],
    );
  }
}

class TaskListModel extends TaskModel {
  late String status;

  TaskListModel(
      {required String taskId,
      required String classId,
      required String className,
      required String description,
      DateTime? datePublished,
      required DateTime finalDate,
      required String status})
      : super(
            taskId: taskId,
            classId: classId,
            className: className,
            description: description,
            datePublished: datePublished,
            finalDate: finalDate);
}
