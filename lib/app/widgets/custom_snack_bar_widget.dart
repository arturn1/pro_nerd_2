import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/values/constants.dart';

class CustomSnack {
  buildCardError(String? message) {
    Get.snackbar(
      "Por favor",
      message!,
      icon: const Icon(Icons.warning, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: kErrorColor40,
      snackStyle: SnackStyle.FLOATING,
      colorText: kOnErrorColor100,
      isDismissible: true,
      dismissDirection: DismissDirection.vertical,
      shouldIconPulse: true,
        padding: const EdgeInsets.symmetric(vertical: kPaddingDefault, horizontal: kPaddingDefault),
        margin: const EdgeInsets.symmetric(vertical: kMarginDefault, horizontal: kMarginDefault)
    );
  }

  buildCardSuccess(String message) {
    Get.snackbar(
      "Parabéns",
      message,
      icon:
          Icon(Icons.assignment_turned_in_outlined, color: kSuccessColorContainer10),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: kSuccessColorContainer90,
      snackStyle: SnackStyle.FLOATING,
      colorText: kOnTertiaryColorContainer10,
        padding: const EdgeInsets.symmetric(vertical: kPaddingDefault, horizontal: kPaddingDefault),
        margin: const EdgeInsets.symmetric(vertical: kMarginDefault, horizontal: kMarginDefault)

    );
  }

  buildCardInformation(String message) {
    Get.snackbar(
      "Vá com calma",
      message,
      icon:
      Icon(Icons.add_circle_outlined, color: kOnPrimaryColorContainer10),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: kInfoColor,
      snackStyle: SnackStyle.FLOATING,
      colorText: kSuccessColorContainer10,
      padding: const EdgeInsets.symmetric(vertical: kPaddingDefault, horizontal: kPaddingDefault),
      margin: const EdgeInsets.symmetric(vertical: kMarginDefault, horizontal: kMarginDefault)
    );
  }

  buildPassInformation(String message) {
    Get.snackbar(
        "Opss!!",
        message,
        icon:
        Icon(Icons.admin_panel_settings_sharp, color: kOnPrimaryColorContainer10),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kInfoColor,
        snackStyle: SnackStyle.FLOATING,
        colorText: kSuccessColorContainer10,
        padding: const EdgeInsets.symmetric(vertical: kPaddingDefault, horizontal: kPaddingDefault),
        margin: const EdgeInsets.symmetric(vertical: kMarginDefault, horizontal: kMarginDefault)
    );
  }

}
