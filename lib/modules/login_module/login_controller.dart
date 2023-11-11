import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../app/data/user.dart';
import '../../app/widgets/custom_snack_bar_widget.dart';
import 'login_service.dart';

class LoginPageController extends GetxController with LoginService {
  final RxString _email = ''.obs;
  final RxString _password = ''.obs;

  setEmail(String value) => _email.value = value;

  setPassword(String value) => _password.value = value;

  Future<void> loginUser() async {
    try {
      LoginViewModel loginViewModel = LoginViewModel(
        name: _email.value,
        email: _email.value,
        password: _password.value,
      );
      await loginUserUsingEmailAndPassword(loginViewModel);
    } catch (e) {
      rethrow;
    }
  }

  throwErrorWidget() {
    CustomSnack().buildCardError('message');
  }

  Future<User?> signInWithGoogle() async {
    await signInWithGoogleService();
    return null;
  }

  String? getEmailError(String? value) {
    if (value!.isEmpty) {
      return ('Campo Obrigatorio');
    } else if (!value.isEmail) {
      return ('E-mail invalido');
    } else {
      return null;
    }
  }

  bool enableLoginButton() {
    return _email.value.isNotEmpty && _password.value.isNotEmpty;
  }

  String? getEmptyError(String? value) {
    if (value!.isEmpty) {
      return ('Campo Obrigatorio');
    } else {
      return null;
    }
  }

  Future messageError() async {
    CustomSnack().buildCardError('Preencha todos os campos com dados válidos');
    return null;
  }
}
