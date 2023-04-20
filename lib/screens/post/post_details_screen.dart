import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../components/constants/color_constants.dart';

class PostDetailScreen extends StatelessWidget {
  final postId;
  const PostDetailScreen({super.key, this.postId});

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Bài đăng',
            style: TextStyle(color: Colors.white, fontSize: 25)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tiêu đề của bài đăng ngày hôm nay là Cheap Thrills',
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
              ),
              const SizedBox(height: 10),
              Text(
                'ngày đăng',
                style: const TextStyle(fontSize: 15, color: textNoteColor),
              ),
              const SizedBox(height: 15),
              Image.asset('assets/images/placeholder.png'),
              const SizedBox(height: 15),
              Text(
                'nội dung',
                style: const TextStyle(fontSize: 18, color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
