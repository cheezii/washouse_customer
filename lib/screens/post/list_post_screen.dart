import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:washouse_customer/screens/post/component/post_card_widget.dart';
import 'package:washouse_customer/screens/post/post_details_screen.dart';

import '../../components/constants/color_constants.dart';
import '../../resource/models/post.dart';
import '../../resource/controller/post_controller.dart';

class ListPostScreen extends StatefulWidget {
  const ListPostScreen({super.key});

  @override
  State<ListPostScreen> createState() => _ListPostScreenState();
}

class _ListPostScreenState extends State<ListPostScreen> {
  PostController postController = PostController();
  List<Post> postList = [];
  bool isLoadingPost = true;

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
    getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (isLoadingPost) {
    //   return Stack(
    //     fit: StackFit.expand,
    //     children: [
    //       Positioned.fill(
    //         child: BackdropFilter(
    //           filter: ImageFilter.blur(
    //             sigmaX: 10.0,
    //             sigmaY: 10.0,
    //           ),
    //           child: Container(
    //             color: Colors.black.withOpacity(0.2),
    //           ),
    //         ),
    //       ),
    //       Positioned(
    //         child: Center(
    //           child: Container(
    //             decoration: BoxDecoration(
    //               color: Colors.white,
    //               borderRadius: BorderRadius.circular(15),
    //             ),
    //             width: 100,
    //             height: 100,
    //             child: LoadingAnimationWidget.threeRotatingDots(
    //                 color: kPrimaryColor, size: 50),
    //           ),
    //         ),
    //       )
    //     ],
    //   );
    // } else {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: kPrimaryColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 23,
            ),
          ),
          centerTitle: true,
          title: const Text('Bài đăng',
              style: TextStyle(color: Colors.white, fontSize: 25)),
        ),
        body: isLoadingPost
            ? Center(
                child: LoadingAnimationWidget.threeRotatingDots(
                    color: kPrimaryColor, size: 50),
              )
            : SingleChildScrollView(
                child: ListView.builder(
                  itemCount: postList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: ((context, index) {
                    return PostCardWidget(
                      title: postList[index].title!,
                      content: postList[index].description!,
                      image: postList[index].thumbnail!,
                      press: () => Navigator.push(
                          context,
                          PageTransition(
                              child: PostDetailScreen(
                                post: postList[index],
                              ),
                              type: PageTransitionType.fade)),
                    );
                  }),
                ),
              ));
  }
  //}
}
