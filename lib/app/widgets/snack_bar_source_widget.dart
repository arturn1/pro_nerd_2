import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/utils/image_picker.dart';
import '../../modules/add_task_module/add_task_page.dart';
import '../../routes/pages.dart';
import 'custom_bottom_bar.dart';

class SelectImageSourceSnackWidget extends StatelessWidget {
  const SelectImageSourceSnackWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 170),
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomBottomBar(),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(padding: EdgeInsets.only(left: 40)),
                _buildBtnWidget(
                    context,
                    'Galeria',
                    Icons.add_photo_alternate,
                    () => ImagePickerHelper()
                        .getFromCamera(ImageSource.gallery)
                        .then((XFile xFile) => Get.toNamed(
                              Routes.addPost,
                              arguments: xFile,
                            ))),
                const Spacer(),
                _buildBtnWidget(
                    context,
                    'Câmera',
                    Icons.add_a_photo,
                    () => ImagePickerHelper()
                        .getFromCamera(ImageSource.camera)
                        .then((imgUrl) => Get.toNamed(
                              Routes.addPost,
                              arguments: imgUrl,
                            ))),
                const Spacer(),
                _buildBtnWidget(
                  context,
                  'Tarefa',
                  Icons.edit,
                  () => Get.bottomSheet(const TaskBottomSheetPage()),
                ),
                const Padding(padding: EdgeInsets.only(right: 40)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildBtnWidget(
    BuildContext context, String title, IconData icon, VoidCallback onTap) {
  return GestureDetector(
    onTap: () => onTap(),
    child: Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(
            icon,
            size: 30,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 10)),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold,
          fontSize: Theme.of(context).textTheme.labelLarge!.fontSize
          ),
        ),
      ],
    ),
  );
}
