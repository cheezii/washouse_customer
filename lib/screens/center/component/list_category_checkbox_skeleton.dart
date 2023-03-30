import 'package:flutter/material.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import 'package:skeletons/skeletons.dart';

class ListCategoriesCheckboxSkeleton extends StatelessWidget {
  const ListCategoriesCheckboxSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) => const CategoryCheckboxSkeleton(),
    );
  }
}

class CategoryCheckboxSkeleton extends StatelessWidget {
  const CategoryCheckboxSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(children: [
        SkeletonLine(
          style: SkeletonLineStyle(
            height: 10,
            width: 150,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const Spacer(),
        const SkeletonAvatar(style: SkeletonAvatarStyle(width: 20, height: 20)),
      ]),
    );
  }
}
