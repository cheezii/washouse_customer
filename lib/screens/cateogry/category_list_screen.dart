import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skeletons/skeletons.dart';
import 'package:washouse_customer/screens/center/center_details_screen.dart';

import '../../components/constants/color_constants.dart';
import '../../resource/controller/category_controller.dart';
import '../../resource/models/category.dart';
import '../center/list_center.dart';
import 'component/list_category.dart';
import 'component/list_category_skeleton.dart';

class ListCategoryScreen extends StatefulWidget {
  const ListCategoryScreen({super.key});

  @override
  State<ListCategoryScreen> createState() => _ListCategoryScreenState();
}

class _ListCategoryScreenState extends State<ListCategoryScreen> {
  List<ServiceCategory> categoryList = [];
  List<ServiceCategory> mainList = [];
  List<ServiceCategory> searchList = [];
  CategoryController categoryController = CategoryController();
  TextEditingController searchController = TextEditingController();
  bool isLoadingCate = true;

  void getCategory() async {
    categoryList = await categoryController.getCategoriesList();
    if (categoryList.isNotEmpty) {
      setState(() {
        isLoadingCate = false;
        mainList = categoryList;
      });
    }
  }

  void getListSearch(String searchValue) {
    setState(() {
      categoryList = mainList
          .where((element) => element.categoryName!
              .toLowerCase()
              .contains(searchValue.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: textColor,
            size: 24,
          ),
        ),
        centerTitle: true,
        title: Text('Các loại dịch vụ',
            style: TextStyle(color: textColor, fontSize: 27)),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm',
                hintStyle: TextStyle(
                    color: Colors.grey.shade500, height: 1, fontSize: 15),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: Colors.grey.shade500,
                  size: 20,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: const EdgeInsets.all(8),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Colors.grey.shade200,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Colors.grey.shade200,
                  ),
                ),
              ),
              style: TextStyle(
                  color: Colors.grey.shade700, height: 1.4, fontSize: 15),
              onChanged: (value) => getListSearch(value),
            ),
            // FutureBuilder(
            //   future: categoryController.getCategoriesList(),
            //   builder: ((context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const ListCategoriesSkeleton();
            //     } else if (snapshot.hasData) {
            //       categoryList = snapshot.data!;
            //       return
            isLoadingCate
                ? const ListCategoriesSkeleton()
                : ListView.builder(
                    itemCount: categoryList.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 16),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListCategory(
                        image: categoryList[index].image!,
                        name: categoryList[index].categoryName!,
                        press: () {
                          int categoryId = categoryList[index].id!;
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: ListCenterScreen(
                                      CategoryServices: "$categoryId",
                                      pageName: "",
                                      isNearby: false,
                                      isSearch: false),
                                  type:
                                      PageTransitionType.rightToLeftWithFade));
                        },
                      );
                    },
                  )
            //     ;
            //   } else if (snapshot.hasError) {
            //     return Column(
            //       children: [
            //         Text('Oops'),
            //         Text('Có lỗi xảy ra rồi!'),
            //       ],
            //     );
            //   }
            //   return Container();
            // }),
            //)
          ],
        ),
      ),
    );
  }
}
