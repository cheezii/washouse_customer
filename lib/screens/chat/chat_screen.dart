import 'package:flutter/material.dart';
import 'package:washouse_customer/constants/color_constants.dart';
import 'package:washouse_customer/models/chat_user.dart';
import 'package:washouse_customer/screens/chat/components/chat.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatUsers> chatUsers = [
    ChatUsers(
      text: 'Trần Tân Long',
      secondaryText: 'Hello bạn',
      image: 'assets/images/profile/2.jpg',
      time: 'Now',
    ),
    ChatUsers(
      text: 'Vũ Quang Minh',
      secondaryText: 'Làm tới đâu rồi?',
      image: 'assets/images/profile/3.jpg',
      time: 'Yesterday',
    ),
    ChatUsers(
      text: 'Phan Nguyễn Quỳnh Chi',
      secondaryText: 'Hello how are you im fint thank you',
      image: 'assets/images/profile/4.jpg',
      time: '18:45',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 18, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Tin nhắn',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Icon(
                      Icons.notifications,
                      color: textColor,
                      size: 30.0,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.grey.shade100,
                    ),
                  ),
                ),
              ),
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ChatUserList(
                  text: chatUsers[index].text,
                  secondaryText: chatUsers[index].secondaryText,
                  image: chatUsers[index].image,
                  time: chatUsers[index].time,
                  isMessageRead: (index == 1 || index == 3) ? true : false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
