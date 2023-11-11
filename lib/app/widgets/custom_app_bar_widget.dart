import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/values/constants.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({Key? key, this.preferredSize = const Size.fromHeight(60)})
      : super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 20),
              child: InkWell(
                onTap: () => Get.back(),
                radius: 50,
                child: Icon(Icons.arrow_back,
                    color: Theme.of(context).colorScheme.inverseSurface,
                    size: Theme.of(context).iconTheme.size),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: 30.0, left: pixelDevice == 3 ? 50 : 80),
                child: Text(
                  'PRO NERD',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inverseSurface,
                    fontSize:
                        Theme.of(context).textTheme.displaySmall?.fontSize,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
