import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/widgets/custom_button_widget.dart';
import '../../app/widgets/custom_input_form_widget.dart';
import '../../app/widgets/custom_snack_bar_widget.dart';
import '../../app/widgets/loader_page_widget.dart';
import '../../app/widgets/logo_widget.dart';
import '../../core/values/constants.dart';
import '../../routes/pages.dart';
import 'forgot_pass_controller.dart';

class ForgotPassPage extends GetView<ForgotPassPageController> {
  const ForgotPassPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(kPaddingDefault),
                    child: Form(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          const Center(child: LogoWidget()),
                          const SizedBox(height: 100),
                          Text(
                            "Recuperação de senha",
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.fontSize,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Por favor, insira seu e-mail para recuperar sua senha.',
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.fontSize,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 40),
                          const SizedBox(height: 10),
                          FormInputWidget(
                            icon: Icons.email,
                            title: "Insira seu e-mail",
                            controller: (v) => controller.setEmail(v),
                            validator: (value) =>
                                controller.getEmailError(value),
                          ),
                          const SizedBox(height: 60)
                        ])))),
            bottomNavigationBar:
            Column(
              mainAxisSize: MainAxisSize.min,
                children: [
              Obx(
                () => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButtonWidget(
                    text: 'Enviar',
                    function:
                        controller.email.isNotEmpty && controller.email.isEmail
                            ? () => Get.offAll(() => LoaderPage(
                                  getData: controller.sendRecovery().whenComplete(
                                      () => CustomSnack().buildCardSuccess(
                                          "Verifique sua caixa de entrada")),
                                  getBack: () => Get.toNamed(Routes.login),
                                  getTo: () => Get.toNamed(Routes.login),
                                ))
                            : () => controller.messageError(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButtonWidget(
                    text: 'Voltar', function: () => Get.back()),
              ),
            ])));
  }
}
