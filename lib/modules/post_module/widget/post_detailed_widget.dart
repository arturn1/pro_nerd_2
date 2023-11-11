import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/data/post.dart';


class PostDetailedWidget extends StatelessWidget {
  PostDetailedWidget({Key? key}) : super(key: key);

  final PostModel snap = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(fit: StackFit.expand, children: [
          Positioned(
            bottom: 30,
            child: SafeArea(
                child: Container(
                    width: Get.width,
                    color: Colors.black,
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Center(
                          child: Text(
                            snap.description,
                            style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                          )),
                    ))),
          ),
          InteractiveViewer(
            child: GestureDetector(
              child: Center(
                child: Hero(
                  tag: snap.postId,
                  child: CachedNetworkImage(
                    imageUrl: snap.postImageUrl,
                    placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                ),
              ),
              onTap: () {
                Get.back();
              },
            ),
          ),
        ]),
      ),
    );
  }
}