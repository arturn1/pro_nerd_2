import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../task_controller.dart';

class TaskPageHeaderWidget extends GetView<TaskPageController> {
  const TaskPageHeaderWidget({Key? key, required this.text})
      : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 60,
      color: Theme.of(context).colorScheme.inversePrimary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.fontSize,
              color: Theme.of(context).colorScheme.inverseSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: Icon(Icons.search,
              color: Theme.of(context).colorScheme.inverseSurface,
              size: Theme.of(context).iconTheme.size,),
            onPressed: () {
              controller.setIsSearching(true);
            },
          )
        ],
      ),
    );
  }
}
