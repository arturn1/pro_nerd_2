import 'package:cloud_firestore/cloud_firestore.dart';

import '../../app/data/post.dart';
import '../../app/data/user.dart';
import '../../core/values/constants.dart';

mixin PostService {

  Stream<List<PostModel>> getPostClassByUser(List<dynamic> classes) {
    return firestore.collection("posts").snapshots().map((QuerySnapshot query) {
      List<PostModel> retVal = [];
      for (var element in query.docs) {
        var postModel = (PostModel.fromSnap(element));
        for (var c in classes) {
          if (c == postModel.classId) {
            retVal.add(postModel);
          }
        }
      }
      retVal.sort((a, b) => a.datePublished.compareTo(b.datePublished));
      return retVal.reversed.toList();
    });
  }

  Future<void> deletePostFromDB(String postId) async {
    try {
      await firestore.collection('posts').doc(postId).delete();
    } catch (err) {
      rethrow;
    }
  }

  Future<List<PostModel>> getPostClass (List<dynamic> classes) {
    return firestore.collection("posts").get().then((QuerySnapshot query) {
      List<PostModel> retVal = [];
      for (var element in query.docs) {
        var postModel = (PostModel.fromSnap(element));
        for (var c in classes) {
          if (c == postModel.classId) {
            retVal.add(postModel);
          }
        }
      }
      retVal.sort((a, b) => a.datePublished.compareTo(b.datePublished));
      return retVal.reversed.toList();
    });
  }

}