import 'package:cloud_firestore/cloud_firestore.dart';

import '../../app/data/user.dart';
import '../../core/values/constants.dart';

mixin ClassService {

  Future<bool> getUserIsFollowingFromDB(String classId, UserModel? user) async {
    var room = await firestore.collection('rooms').doc(classId).get();

    bool following = room.data()!['followers'].contains(user!.uid);
    return following;
  }

  followClassToDB(String classId, UserModel? user) {
    try {
      firestore.collection('rooms').doc(classId).update({
        'followers': FieldValue.arrayUnion([user!.uid])
      });

      firestore.collection('users').doc(user.uid).update({
        'classes': FieldValue.arrayUnion([classId]),
      });

    } catch (e) {
      rethrow;
    }
  }

  unfollowClassToDB(String classId, UserModel? user) {
    try {
      firestore.collection('rooms').doc(classId).update({
        'followers': FieldValue.arrayRemove([user!.uid])
      });

      firestore.collection('users').doc(user.uid).update({
        'classes': FieldValue.arrayRemove([classId]),
      });

    } catch (e) {
      rethrow;
    }
  }

}