// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:washouse_customer/resource/controller/center_controller.dart';

import '../../components/constants/color_constants.dart';
import '../../resource/models/center.dart';
import 'component/list_center_skeleton.dart';
import 'component/screen_list.dart';

class ListCenterScreen extends StatefulWidget {
  final String pageName;
  final bool isSearch;
  final bool isNearby;
  final String? searchString;
  const ListCenterScreen({
    Key? key,
    required this.pageName,
    required this.isSearch,
    required this.isNearby,
    this.searchString,
  }) : super(key: key);

  @override
  State<ListCenterScreen> createState() => _ListCenterScreenState();
}

class _ListCenterScreenState extends State<ListCenterScreen> {
  CenterController centerController = CenterController();
  Future<List<LaundryCenter>>? listAction;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (widget.isSearch) {
      listAction = centerController.getCenterListSearch(widget.searchString!);
    } else if (widget.isNearby) {
      listAction = centerController.getCenterNearby();
    }
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
          title: Text(widget.pageName,
              style: TextStyle(color: textColor, fontSize: 27)),
          actions: [
            GestureDetector(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(
                  Icons.filter_alt_rounded,
                  color: textColor,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Tìm kiếm tiệm giặt',
                    prefixIcon: Icon(Icons.search_rounded),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              FutureBuilder<List<LaundryCenter>>(
                future: listAction,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ListCentersSkeleton();
                  } else if (snapshot.hasData) {
                    List<LaundryCenter> centerList = snapshot.data!;
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: centerList.length,
                        itemBuilder: ((context, index) {
                          bool hasRating =
                              centerList[index].rating != null ? true : false;
                          return Expanded(
                            child: Padding(
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
                            ),
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
