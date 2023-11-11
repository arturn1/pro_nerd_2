import 'package:cloud_firestore/cloud_firestore.dart';

import '../../app/data/room.dart';
import '../../core/values/constants.dart';

mixin SearchClassService {

  Stream<List<RoomModel>> getRoomStream() {
    return firestore.collection('rooms').snapshots().map((QuerySnapshot query) {
      List<RoomModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(RoomModel.fromSnap(element));
      }
      return retVal;
    });
  }
}
