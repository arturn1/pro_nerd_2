import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatModel {
  final String id;
  final String classId;
  final DateTime dateCreated;
  final String uid;
  final String userPhotoURL;
  final String userName;
  final String message;

  ChatModel({
    required this.id,
    required this.classId,
    required this.dateCreated,
    required this.uid,
    required this.userName,
    required this.userPhotoURL,
    required this.message,
  });

  static ChatModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ChatModel(
      id: snapshot["id"],
      classId: snapshot["classId"],
      dateCreated: snapshot["dateCreated"].toDate(),
      userName: snapshot["userName"],
      uid: snapshot["uid"],
      message: snapshot['message'],
      userPhotoURL: snapshot['userPhotoURL'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'classId': classId,
    "dateCreated": dateCreated,
    "userName": userName,
    "uid": uid,
    "message": message,
    "userPhotoURL": userPhotoURL,
  };
}
