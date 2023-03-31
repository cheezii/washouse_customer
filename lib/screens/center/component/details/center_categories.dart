// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../resource/models/service.dart';
import 'category_menu.dart';

class CenterCategoriesSliver extends SliverPersistentHeaderDelegate {
  final ValueChanged<int> onChanged;
  final int selectedIndex;

  CenterCategoriesSliver(
      {required this.onChanged, required this.selectedIndex});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
        height: 52,
        child: CenterCategories(
            onChanged: onChanged, selectedIndex: selectedIndex));
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 56;

  @override
  // TODO: implement minExtent
  double get minExtent => 56;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class CenterCategories extends StatefulWidget {
  final ValueChanged<int> onChanged;
  final int selectedIndex;
  const CenterCategories({
    Key? key,
    required this.onChanged,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  State<CenterCategories> createState() => _CenterCategoriesState();
}

class _CenterCategoriesState extends State<CenterCategories> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          demoCateList.length,
          (index) => Padding(
            padding: const EdgeInsets.only(left: 8),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  foregroundColor: widget.selectedIndex == index
                      ? Colors.black
                      : Colors.black45),
              child: Text(
                demoCateList[index].categoryName,
                style: const TextStyle(fontSize: 22),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
