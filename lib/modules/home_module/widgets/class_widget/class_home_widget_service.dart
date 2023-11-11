import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../app/data/room.dart';
import '../../../../app/data/user.dart';
import '../../../../core/values/constants.dart';

mixin ClassHomeWidgetService {
  Stream<List<RoomModel>> getClassByUser(UserModel? user) {
    return firestore
        .collection("rooms")
        .where("followers", arrayContains: user!.uid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<RoomModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(RoomModel.fromSnap(element));
      }
      return retVal;
    });
  }
}