import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:  Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      height: 7,
    );
  }
}