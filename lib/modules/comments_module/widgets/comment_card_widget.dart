import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import '../../../app/data/comment.dart';


class CommentCard extends StatelessWidget {
  final CommentModel snap;

  const CommentCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  snap.userPhotoURL,
                ),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        snap.userName,
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        snap.description,
                        style: const TextStyle(fontSize: 13),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          Jiffy(snap.datePublished).format('d MMM'),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(thickness: 1,
        color: Colors.transparent,)
      ],
    );
  }
}
