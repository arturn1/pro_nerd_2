
import '../../core/values/constants.dart';

mixin ForgotPassService {

  Future<void> resetPassword(String email) async {
    await firebaseAuth
        .sendPasswordResetEmail(email: email);
  }
}