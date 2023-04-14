import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class CategoriesSkeleton extends StatelessWidget {
  const CategoriesSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .25,
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: 8,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.8,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (context, index) => const CategorySkeleton(),
      ),
    );
  }
}

class CategorySkeleton extends StatelessWidget {
  const CategorySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 8),
            SkeletonLine(
                style: SkeletonLineStyle(
              height: 15,
              width: 60,
              borderRadius: BorderRadius.circular(8),
            )),
          ],
        ),
      ],
    );
  }
}
