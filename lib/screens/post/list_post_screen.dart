import 'package:flutter/material.dart';
import 'package:washouse_customer/screens/post/component/post_card_widget.dart';

import '../../components/constants/color_constants.dart';
import '../../resource/models/post.dart';

class ListPostScreen extends StatefulWidget {
  const ListPostScreen({super.key});

  @override
  State<ListPostScreen> createState() => _ListPostScreenState();
}

class _ListPostScreenState extends State<ListPostScreen> {
  List<Post> postList = [];
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
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
        body: SingleChildScrollView(
          child: ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: ((context, index) {
              return PostCardWidget(
                title: 'tiêu đề',
                content: 'nội dung',
                image: 'assets/images/placeholder.png',
                press: () =>
                    Navigator.pushNamed(context, '/postDetails', arguments: 1),
              );
            }),
          ),
        ));
  }
}
