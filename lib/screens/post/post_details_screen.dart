import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter_html/flutter_html.dart';
import '../../components/constants/color_constants.dart';
import '../../resource/models/post.dart';

class PostDetailScreen extends StatelessWidget {
  final Post post;
  const PostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    print(post.title);
    return Scaffold(
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
        title: const Text('Bài đăng', style: TextStyle(color: Colors.white, fontSize: 25)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${post.title}',
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
              ),
              const SizedBox(height: 10),
              Text(
                '${post.createdDate}',
                style: const TextStyle(fontSize: 15, color: textNoteColor),
              ),
              const SizedBox(height: 15),
              Image.network('${post.thumbnail}'),
              const SizedBox(height: 15),
              Html(data: post.content),
              // Text(
              //   '${post.content}',
              //   style: const TextStyle(fontSize: 18, color: textColor),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
