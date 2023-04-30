import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class BlogSkeleton extends StatelessWidget {
  const BlogSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Stack(
        children: [
          Positioned(
            top: 35,
            left: 15,
            child: SkeletonAvatar(
              style: SkeletonAvatarStyle(
                height: 150,
                width: MediaQuery.of(context).size.width * 0.88,
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
          ),
          const Positioned(
              top: 10,
              left: 25,
              child: SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  height: 150,
                  width: 150,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
