import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!GetPlatform.isWeb) {
      return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 15,
                  spreadRadius: 15,
                  offset: Offset(
                    0,
                    30,
                  ),
                ),
              ],
            ),
            child: const RiveAnimation.asset(
                'assets/rive/1766-3488-projects-icon.riv')),
        bottomNavigationBar: Container(
          color: Colors.white,
          height: 150,
          padding: const EdgeInsets.all(20),
          child: const Center(
            child: Text(
              'PRO NERD',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,
              color: Colors.black),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          color: Colors.white,
          height: Get.height,
          padding: const EdgeInsets.all(20),
          child: const Center(
            child: Text(
              'PRO NERD',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,
                color: Colors.black),
            ),
          ),
        ),
      );
    }
  }
}
