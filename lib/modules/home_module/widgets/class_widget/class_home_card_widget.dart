import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/data/room.dart';
import '../../../../core/values/constants.dart';
import '../../../../routes/pages.dart';

class ClassesHomeCardWidget extends StatelessWidget {
  const ClassesHomeCardWidget({Key? key, required this.roomModel})
      : super(key: key);

  final RoomModel roomModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          Routes.classRoom,
          arguments: roomModel,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.supervisor_account_sharp,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                size: Theme.of(context).iconTheme.size,
              ),
            ),
            const SizedBox(height: 5),
            LimitedBox(
              //maxWidth: 45,
              child: Text(
                roomModel.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                  color: Theme.of(context).colorScheme.onSurface
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
