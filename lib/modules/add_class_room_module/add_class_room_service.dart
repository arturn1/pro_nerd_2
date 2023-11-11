import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../../app/data/room.dart';
import '../../core/values/constants.dart';

mixin AddClassRoomService {
  Future<void> addClassToDB(RoomModel roomModel) async {
    await firestore
        .collection('rooms')
        .doc(roomModel.classId)
        .set(roomModel.toJson());
    await firestore.collection('users').doc(roomModel.uid).update({
      'classes': FieldValue.arrayUnion([roomModel.classId]),
    });
  }

  Future<void> editClassToDB(
      String name, String password, bool isPrivate, String classId) async {
    await firestore
        .collection('rooms')
        .doc(classId)
        .update({"name": name, "password": password, "isPrivate": isPrivate});
  }
}
