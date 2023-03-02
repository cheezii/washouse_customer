import 'package:flutter/material.dart';
import 'package:washouse_customer/constants/color_constants.dart';
import 'package:washouse_customer/models/chat_message.dart';
import 'package:washouse_customer/models/send_menu_item.dart';
import 'package:washouse_customer/screens/chat/components/chat_bubble.dart';

import 'components/chat_detail_page_appbar.dart';

enum MessageType {
  // ignore: constant_identifier_names
  Sender,
  // ignore: constant_identifier_names
  Receiver,
}

class ChatDetailPage extends StatefulWidget {
  ChatDetailPage({super.key});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  List<ChatMessage> chatMessage = [
    ChatMessage(message: 'Hello bạn', type: MessageType.Receiver),
    ChatMessage(message: 'Hi bạn', type: MessageType.Sender),
    ChatMessage(message: 'Nay làm tới đâu dồi?', type: MessageType.Receiver),
    ChatMessage(
        message: 'Ốm sốt chả làm được gì đây :))', type: MessageType.Sender),
    ChatMessage(
        message: 'Bốn ngày là nộp phạt 20k nhá :))',
        type: MessageType.Receiver),
  ];

  List<SendMenuItems> menuItems = [
    SendMenuItems(
        text: 'Photos & Videos', icon: Icons.image, color: Colors.amber),
    //SendMenuItems(text: 'Documents',icon: Icons.insert_drive_file_rounded,color: Colors.blue),
    SendMenuItems(
        text: 'Record', icon: Icons.mic_rounded, color: Colors.orange),
    SendMenuItems(
        text: 'Location', icon: Icons.location_on_rounded, color: Colors.green),
    SendMenuItems(text: 'Contacts', icon: Icons.person, color: Colors.purple),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChatDetailPageAppbar(),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: chatMessage.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ChatBubble(
                chatMessage: chatMessage[index],
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(
                left: 16,
                bottom: 10,
              ),
              height: 80,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showModal();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 21,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Nhập tin nhắn...',
                        hintStyle: TextStyle(color: textNoteColor),
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.only(
                right: 30,
                bottom: 50,
              ),
              child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: kPrimaryColor,
                elevation: 0,
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height / 2,
          color: Color(0xff737373),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Center(
                  child: Container(
                    height: 4,
                    width: 50,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  itemCount: menuItems.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: menuItems[index].color.shade50,
                          ),
                          height: 50,
                          width: 50,
                          child: Icon(
                            menuItems[index].icon,
                            size: 20,
                            color: menuItems[index].color.shade400,
                          ),
                        ),
                        title: Text(menuItems[index].text),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
