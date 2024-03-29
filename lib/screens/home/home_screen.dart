// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:dio/dio.dart';
import 'package:skeletons/skeletons.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/resource/controller/center_controller.dart';
import 'package:washouse_customer/resource/controller/location_controller.dart';
import 'package:washouse_customer/resource/controller/map_controller.dart';
import 'package:washouse_customer/screens/cateogry/category_list_screen.dart';
import 'package:washouse_customer/screens/home/components/blog_skeleton.dart';
import 'package:washouse_customer/screens/home/components/categories_skeleton.dart';
import 'package:washouse_customer/screens/home/components/nearby_center_home_skeleton.dart';
import 'package:washouse_customer/screens/post/list_post_screen.dart';
import 'package:washouse_customer/screens/post/post_details_screen.dart';
import '../../components/constants/text_constants.dart';
import '../../resource/controller/base_controller.dart';
import '../../resource/controller/category_controller.dart';
import '../../resource/controller/post_controller.dart';
import '../../resource/models/category.dart';
import '../../resource/models/post.dart';
import 'package:washouse_customer/resource/models/center.dart';
import '../../resource/models/response_models/notification_item_response.dart';
import '../center/list_center.dart';
import 'components/category_card.dart';
import 'components/home_header.dart';
import 'components/title_with_more_button.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  CenterController centerController = CenterController();
  CategoryController categoryController = CategoryController();
  PostController postController = PostController();
  BaseController baseController = BaseController();
  bool isLoading = true;
  bool isAcceptLocation = true;
  bool isLoadingCate = true;
  bool isLoadingPost = false;
  List<ServiceCategory> categoryList = [];
  List<Post> postList = [];

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  void getPermissionLocation() async {
    print(isLoading);
    isAcceptLocation = await _handleLocationPermission();
    if (isAcceptLocation) {
      setState(() {
        isLoading = false;
        print(isLoading);
      });
    }
  }

  void getCategory() async {
    categoryList = await categoryController.getCategoriesList();
    if (categoryList.isNotEmpty) {
      setState(() {
        isLoadingCate = false;
      });
    }
  }

  void getPosts() async {
    // Show loading indicator
    setState(() {
      isLoadingPost = true;
    });

    try {
      print(13);
      // Wait for getOrderInformation to complete
      List<Post> result = await postController.getPosts();

      setState(() {
        // Update state with loaded data
        postList = result;
        isLoadingPost = false;
      });
    } catch (e) {
      // Handle error
      setState(() {
        isLoadingPost = false;
      });
      print('Error loading post: $e');
    }
  }

  @override
  void initState() {
    getPermissionLocation();
    getCategory();
    getPosts();
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
                    TitleWithMoreBtn(
                        title: 'Các loại dịch vụ',
                        press: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: const ListCategoryScreen(),
                                  type:
                                      PageTransitionType.rightToLeftWithFade));
                        }),
                    FutureBuilder(
                      future: categoryController.getCategoriesList(),
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CategoriesSkeleton();
                        } else if (snapshot.hasData) {
                          categoryList = snapshot.data!;
                          return GridView.builder(
                            shrinkWrap: true,
                            itemCount: categoryList.length > 8
                                ? 8
                                : categoryList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 0.8,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                            ),
                            itemBuilder: ((context, index) {
                              return CategoryCard(
                                icon: categoryList[index].image!,
                                text: categoryList[index].categoryName!,
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
                                          type: PageTransitionType
                                              .rightToLeftWithFade));
                                },
                              );
                            }),
                          );
                        } else if (snapshot.hasError) {
                          return Column(
                            children: [
                              Text('Oops'),
                              Text('Có lỗi xảy ra rồi!'),
                            ],
                          );
                        }
                        return Container();
                      }),
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
                    TitleWithMoreBtn(
                      title: 'Tiệm giặt gần đây',
                      press: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: const ListCenterScreen(
                                  pageName: 'Tiệm giặt gần đây',
                                  isNearby: true,
                                  isSearch: false,
                                ),
                                type: PageTransitionType.rightToLeftWithFade));
                      },
                    ),
                    Skeleton(
                      isLoading: isLoading,
                      skeleton: const NearbyCentersHomeSkeleton(),
                      child: FutureBuilder<List<LaundryCenter>>(
                        future: centerController.getCenterNearby(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const NearbyCenterHomeSkeleton();
                          } else if (snapshot.hasData) {
                            List<LaundryCenter> centerList = snapshot.data!;
                            return SizedBox(
                              height: size.height * .26,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.length,
                                itemBuilder: ((context, index) {
                                  String? fulladdress =
                                      centerList[index].centerAddress;
                                  List<String?> address =
                                      fulladdress!.split(",");
                                  String? currentAddress = address[0];
                                  bool hasRating =
                                      centerList[index].rating != null
                                          ? true
                                          : false;
                                  return GestureDetector(
                                    onTap: () => Navigator.pushNamed(
                                      context,
                                      '/centerDetails',
                                      arguments: centerList[index],
                                    ),
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
                                              fontSize: 18,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
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
                                                            Icons
                                                                .circle_rounded,
                                                            size: 5),
                                                        const SizedBox(
                                                            width: 5),
                                                        const Icon(
                                                            Icons.star_rounded,
                                                            color:
                                                                kPrimaryColor),
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
                    TitleWithMoreBtn(
                        title: 'Bài đăng',
                        press: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: const ListPostScreen(),
                                  type: PageTransitionType.fade));
                        }),
                  ],
                ),
              ),
              FutureBuilder(
                  future: postController.getPosts(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const BlogSkeleton();
                    } else if (snapshot.hasData) {
                      postList = snapshot.data!;
                      return SizedBox(
                        height: size.height * 0.27,
                        child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: postList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  PageTransition(
                                      child: PostDetailScreen(
                                          post: postList[index]),
                                      type: PageTransitionType.fade)),
                              child: SizedBox(
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                                offset:
                                                    const Offset(-10.0, 10.0),
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
                                        shadowColor:
                                            Colors.grey.withOpacity(0.5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  postList[index].thumbnail!),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              postList[index].title!,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              postList[index].description!,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: textNoteColor),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                            // OverflowBox(
                                            //   maxWidth: 20,
                                            //   child: Html(
                                            //     data: postList[index].description!,
                                            //     defaultTextStyle: const TextStyle(fontSize: 15, color: textNoteColor),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Column(
                        children: [
                          Text('Oops'),
                          Text('Có lỗi xảy ra rồi!'),
                        ],
                      );
                    }
                    return Container();
                  })),
              // isLoadingPost
              //     ? SizedBox(
              //         height: size.height * 0.27,
              //         child: Center(
              //             child: LoadingAnimationWidget.twistingDots(
              //           leftDotColor: const Color(0xFF1A1A3F),
              //           rightDotColor: const Color(0xFFEA3799),
              //           size: 200,
              //         )),
              //       )
              //     : SizedBox(
              //         height: size.height * 0.27,
              //         child: PageView.builder(
              //           scrollDirection: Axis.horizontal,
              //           itemCount: postList.length,
              //           itemBuilder: (context, index) {
              //             return SizedBox(
              //               height: 230,
              //               child: Stack(
              //                 children: [
              //                   Positioned(
              //                     top: 35,
              //                     left: 15,
              //                     child: Material(
              //                       child: Container(
              //                         height: 150,
              //                         width: size.width * 0.88,
              //                         decoration: BoxDecoration(
              //                           color: Colors.white,
              //                           borderRadius:
              //                               BorderRadius.circular(0.0),
              //                           boxShadow: [
              //                             BoxShadow(
              //                               color: Colors.grey.withOpacity(0.3),
              //                               offset: const Offset(-10.0, 10.0),
              //                               blurRadius: 20.0,
              //                               spreadRadius: 4.0,
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                   Positioned(
              //                     top: 10,
              //                     left: 25,
              //                     child: Card(
              //                       elevation: 10,
              //                       shadowColor: Colors.grey.withOpacity(0.5),
              //                       shape: RoundedRectangleBorder(
              //                         borderRadius: BorderRadius.circular(15),
              //                       ),
              //                       child: Container(
              //                         height: 150,
              //                         width: 150,
              //                         decoration: BoxDecoration(
              //                           borderRadius: BorderRadius.circular(10),
              //                           image: DecorationImage(
              //                             fit: BoxFit.cover,
              //                             image: AssetImage(
              //                                 postList[index].thumbnail!),
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                   Positioned(
              //                     top: 60,
              //                     left: 187,
              //                     child: SizedBox(
              //                       height: 150,
              //                       width: 180,
              //                       child: Column(
              //                         crossAxisAlignment:
              //                             CrossAxisAlignment.start,
              //                         children: [
              //                           Text(
              //                             postList[index].title!,
              //                             style: const TextStyle(
              //                                 fontWeight: FontWeight.w600,
              //                                 fontSize: 18),
              //                           ),
              //                           const SizedBox(height: 5),
              //                           Text(
              //                             postList[index].content!,
              //                             style: const TextStyle(
              //                                 fontSize: 15,
              //                                 color: textNoteColor),
              //                             overflow: TextOverflow.ellipsis,
              //                             maxLines: 2,
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   )
              //                 ],
              //               ),
              //             );
              //           },
              //         ),
              //       ),
            ],
          ),
        ),
      ),
    );
  }
}
