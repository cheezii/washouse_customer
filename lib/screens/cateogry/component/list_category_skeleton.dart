import 'package:flutter/material.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import 'package:skeletons/skeletons.dart';

class ListCategoriesSkeleton extends StatelessWidget {
  const ListCategoriesSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => const CategorySkeleton(),
      ),
    );
  }
}

class CategorySkeleton extends StatelessWidget {
  const CategorySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 3),
      child: Row(
        children: [
          const SkeletonAvatar(
            style: SkeletonAvatarStyle(
              width: 60,
              height: 60,
              borderRadius: BorderRadius.all(
                Radius.circular(60),
              ),
            ),
          ),
          const SizedBox(width: 20),
          SkeletonLine(
            style: SkeletonLineStyle(
              height: 20,
              width: 150,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const Spacer(),
          const SkeletonAvatar(
              style: SkeletonAvatarStyle(width: 20, height: 25)),
        ],
      ),
    );
  }
}
