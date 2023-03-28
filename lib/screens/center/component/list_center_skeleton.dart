import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ListCentersSkeleton extends StatelessWidget {
  const ListCentersSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => const CenterSkeleton(),
      ),
    );
  }
}

class CenterSkeleton extends StatelessWidget {
  const CenterSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(children: [
        SkeletonAvatar(style: SkeletonAvatarStyle(width: 100, height: 100)),
        SizedBox(width: 15),
        Expanded(
            child: SkeletonParagraph(
          style: SkeletonParagraphStyle(
              lines: 3,
              spacing: 14,
              lineStyle: SkeletonLineStyle(
                randomLength: true,
                height: 10,
                borderRadius: BorderRadius.circular(8),
                minLength: MediaQuery.of(context).size.width / 2,
              )),
        )),
      ]),
    );
  }
}
