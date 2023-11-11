import 'package:get/get.dart';
import '../../app/widgets/custom_snack_bar_widget.dart';
import 'forgot_pass_service.dart';

class ForgotPassPageController extends GetxController with ForgotPassService {

  final RxString _email = ''.obs;

  setEmail(String v) => _email.value = v;

  String get email => _email.value;

  Future<void> sendRecovery() async {
    await resetPassword(_email.value);
}

  String? getEmailError(String value) {
    if (!value.isEmail) {
      return ('E-mail inválido');
    } else {
      return null;
    }
  }

  Future messageError() async {
    CustomSnack().buildCardError('Preencha todos os campos com dados válidos');
    return null;
  }

}