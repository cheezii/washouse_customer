// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:washouse_customer/resource/controller/category_controller.dart';

import 'package:washouse_customer/resource/controller/center_controller.dart';
import 'package:washouse_customer/resource/models/category.dart';

import '../../components/constants/color_constants.dart';
import '../../resource/models/center.dart';
import '../home/components/search_bar_home.dart';
import 'component/list_center_skeleton.dart';
import 'component/screen_list.dart';
import 'component/sort_model_bottom.dart';

class ListCenterScreen extends StatefulWidget {
  final String pageName;
  final bool isNearby;
  final bool isSearch;
  final String? searchString;
  const ListCenterScreen({
    Key? key,
    required this.pageName,
    required this.isNearby,
    required this.isSearch,
    this.searchString,
  }) : super(key: key);

  @override
  State<ListCenterScreen> createState() => _ListCenterScreenState();
}

class _ListCenterScreenState extends State<ListCenterScreen> {
  CenterController centerController = CenterController();
  CategoryController categoryController = CategoryController();
  Future<List<LaundryCenter>>? listAction;
  List<LaundryCenter> allCenter = [];
  List<LaundryCenter> suggesCenter = [];
  List<ServiceCategory> cateList = [];
  List<String> sortList = ["location", "rating"];

  final TextEditingController searchController = TextEditingController();

  String sortChoosen = 'Sắp xếp theo';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void suggestionList(String value) {
    setState(() {
      suggesCenter = allCenter
          .where((element) =>
              element.title!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void getCategory() async {
    cateList = await categoryController.getCategoriesList();
  }

  @override
  void initState() {
    getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isNearby) {
      listAction = centerController.getCenterNearby();
    } else if (searchController.text.isNotEmpty) {
      listAction = centerController.getCenterListSearch(searchController.text);
    } else if (widget.searchString != null) {
      listAction = centerController.getCenterListSearch(widget.searchString!);
    } else {
      listAction = centerController.getCenterList();
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
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
          title: Text(widget.pageName,
              style: const TextStyle(color: textColor, fontSize: 27)),
          actions: [
            // GestureDetector(
            //   onTap: () {},
            //   child: const Padding(
            //     padding: EdgeInsets.only(right: 16),
            //     child: Icon(
            //       Icons.filter_alt_rounded,
            //       color: textColor,
            //       size: 30,
            //     ),
            //   ),
            // ),
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearch(),
                );
              },
              icon:
                  const Icon(Icons.search_rounded, color: textColor, size: 30),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   height: 40,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: Colors.grey.shade200,
              //     borderRadius: BorderRadius.circular(30),
              //   ),
              //   child: TextField(
              //     onChanged: (value) => suggestionList(value),
              //     textInputAction: TextInputAction.search,
              //     controller: searchController,
              //     autofocus: widget.isSearch ? true : false,
              //     decoration: const InputDecoration(
              //       enabledBorder: InputBorder.none,
              //       focusedBorder: InputBorder.none,
              //       hintText: 'Tìm kiếm tiệm giặt',
              //       prefixIcon: Icon(Icons.search_rounded),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () =>
                    SortModalBottomSheet.buildShowSortModalBottom(context),
                child: Container(
                  width: 125,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade500),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(sortChoosen),
                        const SizedBox(width: 4),
                        const Icon(Icons.keyboard_arrow_down_rounded)
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FutureBuilder<List<LaundryCenter>>(
                future: listAction,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ListCentersSkeleton();
                  } else if (snapshot.hasData) {
                    List<LaundryCenter> centerList = snapshot.data!;
                    if (!widget.isNearby || searchController.text.isEmpty) {
                      allCenter = centerList;
                    }
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: centerList.length,
                        itemBuilder: ((context, index) {
                          bool hasRating =
                              centerList[index].rating != null ? true : false;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: ListCenter(
                                thumbnail: centerList[index].thumbnail!,
                                name: centerList[index].title!,
                                distance: centerList[index].distance!,
                                rating: hasRating
                                    ? centerList[index].rating!
                                    : null,
                                hasRating: hasRating,
                                press: () {}),
                          );
                        }),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    //return Container();
                    return Column(
                      children: const [
                        SizedBox(height: 20),
                        Text(
                          'Oops',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 7),
                        Text(
                          'Có lỗi xảy ra rồi!',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ));
  }
}
