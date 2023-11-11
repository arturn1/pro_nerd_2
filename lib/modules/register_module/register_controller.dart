import 'package:get/get.dart';
import 'package:cam/modules/register_module/register_service.dart';

import '../../app/data/user.dart';
import '../../app/widgets/custom_snack_bar_widget.dart';

class RegisterPageController extends GetxController with RegisterService {

  final RxString _newEmail = ''.obs;
  final RxString _newUserName = ''.obs;
  final RxString _newPassword = ''.obs;
  final RxString _newConfirmedPassword = ''.obs;

  setNewEmail(String value) => _newEmail.value = value;
  setNewName(String value) => _newUserName.value = value;
  setNewPassword(String value) => _newPassword.value = value;
  setNewConfirmedPassword(String value) => _newConfirmedPassword.value = value;

  Future<void> registerUser() async {
    RegisterUserViewModel registerUserViewModel = RegisterUserViewModel(
        name: _newUserName.value,
        email: _newEmail.value,
        password: _newPassword.value,
        confirmPassword: _newConfirmedPassword.value);
    await registerUserToGoogle(registerUserViewModel);
  }

  bool enableRegisterButton() {
    return _newUserName.isNotEmpty &&
        _newEmail.isNotEmpty &&
        _newConfirmedPassword.value.length > 8 &&
        _newPassword.value.length > 8 &&
        _newEmail.value.isEmail &&
        _newConfirmedPassword.value == _newPassword.value;
  }

  Future messageError() async {
    CustomSnack().buildCardError('Preencha todos os campos com dados válidos');
    return null;
  }

  String? getPasswordError(String? value) {
    if (value!.length <= 8) {
      return 'A senha deve conter mais de 8 caracteres';
    } else {
      return null;
    }
  }

  String? getConfirmPasswordError(String? value) {
    if (value != _newPassword.value) {
      return 'As senhas nao coincidem';
    } else {
      return null;
    }
  }

  String? getNameError(String? value) {
    if (value!.isEmpty) {
      return 'Campo Obrigatorio';
    } else {
      return null;
    }
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

}