import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cam/modules/add_post_module/widget/add_post_drop_down_widget.dart';
import 'package:image_picker/image_picker.dart';


import '../../app/widgets/custom_button_widget.dart';
import '../../app/widgets/custom_header_widget.dart';
import '../../app/widgets/custom_snack_bar_widget.dart';
import '../../core/values/constants.dart';
import '../../routes/pages.dart';
import '../base_module/base_controller.dart';
import 'add_post_controller.dart';

class AddPostPage extends GetView<AddPostController> {
  AddPostPage({
    Key? key,
  }) : super(key: key);

  final XFile image = Get.arguments;
  BaseController baseController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: GestureDetector(
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: Theme.of(context).colorScheme.inverseSurface,
                          ),
                          onTap: () => Get.back(),
                        ),
                      ),
                      const SizedBox(width: 20),
                      const CustomHeader(text: 'Postar'),
                    ],
                  )),
              Container(
                padding: const EdgeInsets.all(kPaddingDefault),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GetPlatform.isWeb
                            ? Image.network(
                                image.path,
                                height: Get.height * .5,
                              )
                            : Image.file(
                                File(image.path),
                                height: Get.height * .5,
                              )),
                    const SizedBox(
                      height: 20,
                    ),
                    const AddPostDropDownWidget(),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(40),
                        ],
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (v) => controller.setDescription(v),
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        decoration: const InputDecoration(
                            labelText: 'Descrição',
                            hintMaxLines: 1,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.green, width: 4.0))),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButtonWidget(
                      text: 'Salvar',
                      function: () =>
                      controller.className.isNotEmpty
                          ? {
                              controller.addPost(image),
                              Get.offAllNamed(Routes.base),
                              baseController.animateTo(0)
                            }
                          :
                      CustomSnack().buildCardError('Selecione um grupo'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
