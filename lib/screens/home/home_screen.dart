// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:dio/dio.dart';

import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/resource/controller/center_controller.dart';
import 'package:washouse_customer/screens/home/components/nearby_center_home_skeleton.dart';
import '../../resource/models/category.dart';
import '../../resource/models/post.dart';
import 'package:washouse_customer/resource/models/center.dart';
import '../center/list_center_screen.dart';
import 'components/category_card.dart';
import 'components/home_header.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  CenterController centerController = CenterController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const HomeHeader(),
              const SizedBox(height: 10),
              Divider(thickness: 1, color: Colors.grey.shade300),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Các loại dịch vụ',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                    // GridView.builder(
                    //   shrinkWrap: true,
                    //   itemCount: 12,
                    //   gridDelegate:
                    //       const SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 4,
                    //     childAspectRatio: 0.8,
                    //     crossAxisSpacing: 15,
                    //     mainAxisSpacing: 15,
                    //   ),
                    //   itemBuilder: ((context, index) {
                    //     return CategoryCard(
                    //       icon: categoryList[index].thumbnail,
                    //       text: categoryList[index].name,
                    //       press: () {},
                    //     );
                    //   }),
                    // ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Divider(thickness: 8, color: Colors.grey.shade200),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tiệm giặt gần đây',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: const ListCenterScreen(
                                      pageName: 'Tiệm giặt gần đây',
                                      isNearby: true,
                                      isSearch: false,
                                    ),
                                    type: PageTransitionType
                                        .rightToLeftWithFade));
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    FutureBuilder<List<LaundryCenter>>(
                      future: centerController.getCenterNearby(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const NearbyCenterHomeSkeleton();
                        } else if (snapshot.hasData) {
                          List<LaundryCenter> centerList = snapshot.data!;
                          return SizedBox(
                            height: size.height * .25,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: ((context, index) {
                                String? fulladdress =
                                    centerList[index].centerAddress;
                                List<String?> address = fulladdress!.split(",");
                                String? currentAddress = address[0];
                                bool hasRating =
                                    centerList[index].rating != null
                                        ? true
                                        : false;
                                return GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 170,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 1.5,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Image.network(
                                                centerList[index].thumbnail!),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          centerList[index].title!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          currentAddress!,
                                          style: TextStyle(
                                              color: Colors.grey.shade600),
                                        ),
                                        const SizedBox(height: 2),
                                        Row(
                                          children: [
                                            Text(
                                                '${centerList[index].distance} km'),
                                            const SizedBox(width: 5),
                                            hasRating
                                                ? Row(
                                                    children: [
                                                      const Icon(
                                                          Icons.circle_rounded,
                                                          size: 5),
                                                      const SizedBox(width: 5),
                                                      const Icon(
                                                          Icons.star_rounded,
                                                          color: kPrimaryColor),
                                                      Text(
                                                          '${centerList[index].rating}')
                                                    ],
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          //return Container();
                          // if (snapshot.error.runtimeType == DioError) {
                          //   DioError _error = snapshot.error as DioError;

                          // }
                          return Column(
                            children: [
                              Text('Oops'),
                              Text('Có lỗi xảy ra rồi!'),
                            ],
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Divider(thickness: 8, color: Colors.grey.shade200),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Blog tiệm giặt',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.27,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: postList.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 230,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 35,
                            left: 15,
                            child: Material(
                              child: Container(
                                height: 150,
                                width: size.width * 0.88,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(0.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      offset: const Offset(-10.0, 10.0),
                                      blurRadius: 20.0,
                                      spreadRadius: 4.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 25,
                            child: Card(
                              elevation: 10,
                              shadowColor: Colors.grey.withOpacity(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage(postList[index].thumbnail),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 60,
                            left: 187,
                            child: SizedBox(
                              height: 150,
                              width: 180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    postList[index].title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    postList[index].content,
                                    style: const TextStyle(
                                        fontSize: 15, color: textNoteColor),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
