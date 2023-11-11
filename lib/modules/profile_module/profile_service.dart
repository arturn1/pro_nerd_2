import '../../app/data/user.dart';
import '../../core/values/constants.dart';

mixin ProfileService {

  Future<UserModel> getUserData(String uid) async {
    var user = await firestore
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();
    var n = UserModel.fromSnap(user.docs.single);
    return n;
  }

}