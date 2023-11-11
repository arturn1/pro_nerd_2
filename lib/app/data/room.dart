import 'package:cloud_firestore/cloud_firestore.dart';

class RoomModel {
  final String classId;
  final String name;
  final String uid;
  final String userName;
  final bool isPrivate;
  final String password;
  final DateTime dateCreated;
  final List followers;

  const RoomModel(
      {required this.classId,
      required this.name,
      required this.uid,
      required this.password,
      required this.isPrivate,
      required this.userName,
      required this.dateCreated,
      required this.followers});

  static RoomModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return RoomModel(
        uid: snapshot["uid"],
        password: snapshot["password"],
        name: snapshot["name"],
        isPrivate: snapshot["isPrivate"],
        classId: snapshot["classId"],
        dateCreated: snapshot["dateCreated"].toDate(),
        userName: snapshot["userName"],
        followers: snapshot["followers"]);
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "password": password,
        "userName": userName,
        "classId": classId,
        "dateCreated": dateCreated,
        "followers": followers,
        "isPrivate": isPrivate
      };
}
