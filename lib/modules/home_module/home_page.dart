import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cam/modules/home_module/widgets/class_widget/class_home_widget.dart';
import 'package:cam/modules/home_module/widgets/post_widget/post_home_widget.dart';
import 'package:cam/modules/home_module/widgets/task_widget/task_home_widget.dart';

class HomePage extends GetView {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: const [
          ClassHomeWidget(),
          TaskHomeWidget(),
          PostHomeWidget(),
        ],
      ),
    ])
    ;
  }
}
