import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../app/data/post.dart';
import '../../../../core/values/constants.dart';

mixin class ClassRoomPostWidgetService {

  Stream<List<PostModel>> getPostStreamByClass(String classId) {
    return firestore
        .collection("posts")
        .where("classId", isEqualTo: classId)
        .orderBy("datePublished", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<PostModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(PostModel.fromSnap(element));
      }
      return retVal;
    });
  }

  Future<List<PostModel>> getPostClass (String classId) {
    return firestore.collection("posts").get().then((QuerySnapshot query) {
      List<PostModel> retVal = [];
      for (var element in query.docs) {
        var postModel = (PostModel.fromSnap(element));
          if (classId == postModel.classId) {
            retVal.add(postModel);
          }
      }
      retVal.sort((a, b) => a.datePublished.compareTo(b.datePublished));
      return retVal.reversed.toList();
    });
  }

}