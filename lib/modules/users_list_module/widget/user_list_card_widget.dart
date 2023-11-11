import 'package:flutter/material.dart';

import '../../../app/data/user.dart';

class UserCard extends StatelessWidget {
  final UserModel snap;

  const UserCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  snap.photoUrl,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(snap.userName),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(thickness: 1, color: Colors.transparent,)
      ],
    );
  }
}
