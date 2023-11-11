import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../app/data/post.dart';
import '../../../../core/utils/verify_data.dart';
import '../../../../core/values/constants.dart';
import '../../../../routes/pages.dart';

class ClassRoomPostCardWidget extends StatelessWidget {
  const ClassRoomPostCardWidget({Key? key, required this.snap})
      : super(key: key);

  final PostModel snap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kMarginDefault / 3),
      child: Stack(children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GestureDetector(
              onTap: () => Get.toNamed(Routes.detailedPost, arguments: snap),
              child: Hero(
                tag: snap.postId,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: snap.postImageUrl,
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 11,
          left: 14,
          child: SizedBox(
            height: 38,
            width: 125,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                  border: Border.all(
                    color: Colors.white,
                  ),
                  color: Colors.black45),
              child: Container(
                padding:
                    const EdgeInsets.only(top: 10, left: 38),
                child: Text(
                  DatePickerHelper.instance
                      .showDateLikeInsta(snap.datePublished),
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleSmall?.fontSize,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 12,
          left: 15,
          child: SizedBox(
            height: 36,
            width: 36,
            child: CircleAvatar(
              backgroundImage: NetworkImage(snap.userPhotoURL),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: SizedBox(
            height: 40,
            width: 125,
            child: TextButton.icon(
              icon: const Icon(Icons.comment),
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.white),
                ),
                primary: Colors.white,
                backgroundColor: Colors.black45,
              ),
              onPressed: () =>
                  Get.toNamed(Routes.comments, arguments: snap.postId),
              label: Text(snap.commentLength.toString()),
            ),
          ),
        ),
      ]),
    );
  }
}
