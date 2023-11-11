import 'package:firebase_auth/firebase_auth.dart';

import '../../app/data/user.dart';
import '../../core/values/constants.dart';

mixin RegisterService {

  Future<void> registerUserToGoogle(
      RegisterUserViewModel registerUserViewModel) async {
    try {
      UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
        email: registerUserViewModel.email,
        password: registerUserViewModel.confirmPassword,
      );

      User? user = cred.user!;

      await user.updateDisplayName(registerUserViewModel.name);
      await user.updatePhotoURL(
          'https://avatars.githubusercontent.com/u/31557902?v=4');

      UserModel userModel = UserModel(
          userName: registerUserViewModel.name,
          email: registerUserViewModel.name,
          uid: cred.user!.uid,
          photoUrl: 'https://avatars.githubusercontent.com/u/31557902?v=4',
          followers: [],
          following: []);
      await firestore
          .collection('users')
          .doc(cred.user!.uid)
          .set(userModel.toJson());
    } catch (e) {
      rethrow;
    }
  }
}