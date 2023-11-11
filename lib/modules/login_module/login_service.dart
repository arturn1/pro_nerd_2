import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../app/data/user.dart';
import '../../core/values/constants.dart';

mixin LoginService {

  Future<void> loginUserUsingEmailAndPassword(
      LoginViewModel loginViewModel) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: loginViewModel.email, password: loginViewModel.password);
      final user = userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> signInWithGoogleService() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
        await auth.signInWithPopup(authProvider);

        user = userCredential.user;

        user = userCredential.user;
        UserModel userModel = userMapGoogleToUser(user);

        var dataList = await firestore
            .collection("users")
            .where("uid", isEqualTo: user!.uid)
            .get();

        if (dataList.size == 0) {
          await firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .set(userModel.toJson());
        }

      } catch (e) {
        rethrow;
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
      await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
          await auth.signInWithCredential(credential);

          user = userCredential.user;
          UserModel userModel = userMapGoogleToUser(user);

          var dataList = await firestore
              .collection("users")
              .where("uid", isEqualTo: user!.uid)
              .get();

          if (dataList.size == 0) {
            await firestore
                .collection('users')
                .doc(userCredential.user!.uid)
                .set(userModel.toJson());
          }

        } on FirebaseAuthException catch (e) {
          rethrow;
        } catch (e) {
          rethrow;
        }
      }
    }
    return user;
  }

  UserModel userMapGoogleToUser(User? user) {
    return UserModel(
        userName: user!.displayName!,
        email: user.email!,
        uid: user.uid,
        photoUrl: user.photoURL!,
        followers: [],
        following: []);
  }
}