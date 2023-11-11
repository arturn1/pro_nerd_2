import 'package:cloud_firestore/cloud_firestore.dart';

import '../../app/data/room.dart';
import '../../app/data/user.dart';
import '../../core/values/constants.dart';

mixin UserListService {

  Stream<List<UserModel>> userStreamFromDB(RoomModel roomModel) {
    return firestore
        .collection("users")
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserModel> retVal = [];
      for (var element in query.docs) {
        if(roomModel.followers.contains(UserModel.fromSnap(element).uid)) {
          retVal.add(UserModel.fromSnap(element));
        }
      }
      retVal.sort((a, b) => a.userName.compareTo(b.userName));
      return retVal;

    });
  }
}