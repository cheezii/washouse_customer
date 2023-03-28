import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class NearbyCentersHomeSkeleton extends StatelessWidget {
  const NearbyCentersHomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) => const NearbyCenterHomeSkeleton(),
    );
  }
}

class NearbyCenterHomeSkeleton extends StatelessWidget {
  const NearbyCenterHomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SkeletonAvatar(
              style: SkeletonAvatarStyle(
                width: 170,
                height: 100,
              ),
            ),
            const SizedBox(width: 8),
            SkeletonParagraph(
              style: SkeletonParagraphStyle(
                  lines: 3,
                  spacing: 6,
                  lineStyle: SkeletonLineStyle(
                    randomLength: true,
                    height: 8,
                    borderRadius: BorderRadius.circular(8),
                    minLength: MediaQuery.of(context).size.width / 6,
                    maxLength: MediaQuery.of(context).size.width / 3,
                  )),
            )
          ],
        ),
        const SizedBox(width: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SkeletonAvatar(
              style: SkeletonAvatarStyle(
                width: 170,
                height: 105,
              ),
            ),
            const SizedBox(width: 8),
            SkeletonParagraph(
              style: SkeletonParagraphStyle(
                  lines: 3,
                  spacing: 6,
                  lineStyle: SkeletonLineStyle(
                    randomLength: true,
                    height: 8,
                    borderRadius: BorderRadius.circular(8),
                    minLength: MediaQuery.of(context).size.width / 6,
                    maxLength: MediaQuery.of(context).size.width / 3,
                  )),
            )
          ],
        ),
      ],
    );
  }
}
