import 'package:flutter/material.dart';
import '../../core/values/constants.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.inversePrimary,
            blurRadius: 15,
            spreadRadius: 15,
            offset: const Offset(
              0,
              -50,
            ),
          ),
        ],
      ),
      alignment: Alignment.center,
      height: 60,
      child: Text(
        text,
        style: TextStyle(
          fontSize: Theme.of(context)
            .textTheme
            .headlineMedium
            ?.fontSize,
          letterSpacing: .01,
          color: Theme.of(context).colorScheme.inverseSurface,
          fontWeight: FontWeight.bold,
          fontFamily: 'myFont',
        ),
      ),
    );
  }
}
