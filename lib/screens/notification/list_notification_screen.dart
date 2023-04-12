import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:washouse_customer/resource/controller/notification_controller.dart';

import '../../components/constants/color_constants.dart';
import '../../resource/models/response_models/notification_item_response.dart';
import '../../resource/models/response_models/notification.dart';
import 'component/notification_list.dart';

class ListNotificationScreen extends StatefulWidget {
  const ListNotificationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ListNotificationScreen> createState() => _ListNotificationScreenState();
}

class _ListNotificationScreenState extends State<ListNotificationScreen> {
  NotificationController notificationController = NotificationController();
  List<NotificationItem> notifications = [];
  int countUnread = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // centerArgs = widget.orderId;
    getNotifications();
  }

  void getNotifications() async {
    // Show loading indicator
    setState(() {
      isLoading = true;
    });

    try {
      // Wait for getOrderInformation to complete
      NotificationResponse result = await notificationController.getNotifications();
      setState(() {
        // Update state with loaded data
        if (result.notifications != null) {
          notifications = result.notifications!;
          countUnread = result.numOfUnread!;
        }
        isLoading = false;
      });
    } catch (e) {
      // Handle error
      setState(() {
        isLoading = false;
      });
      print('Error loading data: $e');
    }
  }

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
            size: 24,
          ),
        ),
        centerTitle: true,
        title: const Text('Thông báo', style: TextStyle(color: Colors.white, fontSize: 27)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.check_circle_outline_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              padding: const EdgeInsets.only(top: 16),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: NotificationList(
                    title: notifications[index].title!,
                    content: notifications[index].content!,
                    image: 'assets/images/logo/washouse-favicon.png',
                    time: notifications[index].createdDate!,
                    isNotiRead: notifications[index].isRead!,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
