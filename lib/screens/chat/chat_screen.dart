import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/resource/controller/base_controller.dart';
import 'package:washouse_customer/resource/models/chat_user.dart';
import 'package:washouse_customer/resource/provider/chat_provider.dart';
import 'package:washouse_customer/screens/chat/chat_detail_screen.dart';
import 'package:washouse_customer/utils/time_utils.dart';

import '../../components/constants/firestore_constants.dart';
import '../../resource/models/chat_message.dart';
import '../../utils/debouncer.dart';
import '../../utils/keyboard_util.dart';
import '../notification/list_notification_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List chatList = [];
  final ScrollController listScrollController = ScrollController();

  int _limit = 20;
  final int _limitIncrement = 20;
  String _textSearch = "";
  bool isLoading = false;
  bool isLoadingList = true;

  late final ChatProvider chatProvider = context.read<ChatProvider>();
  late final int currentUserId;
  final firebaseStore = FirebaseFirestore.instance;
  final Debouncer searchDebouncer = Debouncer(milliseconds: 300);
  final StreamController<bool> btnClearController = StreamController<bool>();
  final TextEditingController searchController = TextEditingController();
  BaseController baseController = BaseController();

  @override
  void initState() {
    super.initState();
    _loadData();
    listScrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    btnClearController.close();
  }

  Future<void> _loadData() async {
    currentUserId =
        await baseController.getInttoSharedPreference("CURRENT_USER_ID");

    var fromMsg = await firebaseStore
        .collection(FirestoreConstants.pathMessageCollection)
        .withConverter(
            fromFirestore: ((snapshot, _) =>
                MessageData.fromDocument(snapshot)),
            toFirestore: (MessageData msg, options) => msg.toJson())
        .where('idFrom', isEqualTo: currentUserId.toString())
        .get();

    var toMsg = await firebaseStore
        .collection(FirestoreConstants.pathMessageCollection)
        .withConverter(
            fromFirestore: ((snapshot, _) =>
                MessageData.fromDocument(snapshot)),
            toFirestore: (MessageData msg, options) => msg.toJson())
        .where('idTo', isEqualTo: currentUserId.toString())
        .get();

    setState(() {
      if (fromMsg.docs.isNotEmpty) {
        chatList.addAll(fromMsg.docs);
      }
      if (toMsg.docs.isNotEmpty) {
        chatList.addAll(toMsg.docs);
      }
    });
  }

  void scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (chatList.length > 0) {
      isLoadingList = false;
    }
    return Scaffold(
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 18, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tin nhắn',
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: const ListNotificationScreen(),
                              type: PageTransitionType.rightToLeftWithFade));
                    },
                    icon: const Icon(
                      Icons.notifications,
                      color: textColor,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          buildSearchBar(),
          Expanded(
            child: Skeleton(
              isLoading: isLoadingList,
              skeleton: CircularProgressIndicator(),
              child: ListView.builder(
                itemCount: chatList.length,
                itemBuilder: (context, index) {
                  var item = chatList[index];
                  return buildMsgListItem(item);
                },
              ),
            ),
          ),
          // Expanded(
          //   child: StreamBuilder<QuerySnapshot>(
          //     stream: chatProvider.getStreamFireStore(
          //         FirestoreConstants.pathListChatCollection,
          //         _limit,
          //         _textSearch,
          //         currentUserId.toString()).asBroadcastStream(),
          //     builder: (BuildContext context,
          //         AsyncSnapshot<QuerySnapshot> snapshot) {
          //       if (snapshot.hasData) {
          //         if ((snapshot.data?.docs.length ?? 0) > 0) {
          //           return ListView.builder(
          //             padding: EdgeInsets.all(10),
          //             itemBuilder: (context, index) =>
          //                 buildItem(context, snapshot.data?.docs[index]),
          //             itemCount: snapshot.data?.docs.length,
          //             controller: listScrollController,
          //           );
          //         } else {
          //           return Padding(
          //             padding: const EdgeInsets.only(top: 60),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
          //                 Container(
          //                   height: 150,
          //                   width: 150,
          //                   padding: const EdgeInsets.all(10),
          //                   decoration: BoxDecoration(
          //                     color: const Color(0xffD4DEFE),
          //                     borderRadius: BorderRadius.circular(100),
          //                   ),
          //                   child: Image.asset(
          //                       'assets/images/sticker/app_icon.png'),
          //                 ),
          //                 const SizedBox(height: 15),
          //                 const Text(
          //                   'Không có đoạn chat nào',
          //                   style: TextStyle(
          //                       fontSize: 20,
          //                       color: textColor,
          //                       fontWeight: FontWeight.w500),
          //                 ),
          //               ],
          //             ),
          //           );
          //         }
          //       } else {
          //         return Padding(
          //           padding: const EdgeInsets.only(top: 60),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               Container(
          //                 height: 150,
          //                 width: 150,
          //                 padding: const EdgeInsets.all(10),
          //                 decoration: BoxDecoration(
          //                   color: const Color(0xffD4DEFE),
          //                   borderRadius: BorderRadius.circular(100),
          //                 ),
          //                 child:
          //                     Image.asset('assets/images/sticker/app_icon.png'),
          //               ),
          //               const SizedBox(height: 15),
          //               const Text(
          //                 'Không có đoạn chat nào',
          //                 style: TextStyle(
          //                     fontSize: 20,
          //                     color: textColor,
          //                     fontWeight: FontWeight.w500),
          //               ),
          //             ],
          //           ),
          //         );
          //       }
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget buildSearchBar() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: TextField(
        textInputAction: TextInputAction.search,
        controller: searchController,
        onChanged: (value) {
          searchDebouncer.run(() {
            if (value.isNotEmpty) {
              btnClearController.add(true);
              setState(() {
                _textSearch = value;
              });
            } else {
              btnClearController.add(false);
              setState(() {
                _textSearch = "";
              });
            }
          });
        },
        decoration: InputDecoration(
          hintText: 'Tìm kiếm',
          hintStyle: TextStyle(color: Colors.grey.shade500),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: Colors.grey.shade500,
            size: 20,
          ),
          // suffixIcon: StreamBuilder<bool>(
          //     stream: btnClearController.stream.asBroadcastStream(),
          //     builder: (context, snapshot) {
          //       return snapshot.data == true
          //           ? GestureDetector(
          //               onTap: () {
          //                 searchController.clear();
          //                 btnClearController.add(false);
          //                 setState(() {
          //                   _textSearch = "";
          //                 });
          //               },
          //               child: Icon(Icons.clear_rounded,
          //                   color: Colors.grey.shade500, size: 20))
          //           : SizedBox.shrink();
          //     }),
          filled: true,
          fillColor: Colors.grey.shade200,
          contentPadding: const EdgeInsets.all(8),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
        ),
        style: TextStyle(height: 1.7),
      ),
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot? document) {
    if (document != null) {
      ChatUser userChat = ChatUser.fromDocument(document);
      if (userChat.peerId == currentUserId.toString()) {
        return SizedBox.shrink();
      } else {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ChatDetailPage(
                    arguments: ChatPageArguments(
                        peerId: userChat.peerId.toString(),
                        peerAvatar: userChat.photoUrl,
                        peerNickname: userChat.name),
                  );
                },
              ),
            );
          },
          child: Container(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(userChat.photoUrl),
                        maxRadius: 30,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(userChat.name),
                              const SizedBox(height: 6),
                              Text(
                                userChat.type == 0
                                    ? userChat.recentMessage
                                    : userChat.type == 2
                                        ? '[Sticker]'
                                        : '[Hình ảnh]',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey.shade500),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  TimeUtils().checkOver24Hours(DateFormat('yyyy-MM-dd HH:mm:ss')
                          .format(DateTime.parse(userChat.timestamp)))
                      ? DateFormat('HH:mm')
                          .format(DateTime.parse(userChat.timestamp))
                      : DateFormat('dd-MM')
                          .format(DateTime.parse(userChat.timestamp)),
                  //DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(userChat.timestamp)),
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                )
              ],
            ),
          ),
        );
      }
    } else {
      return SizedBox.shrink();
    }
  }

  Widget buildMsgListItem(DocumentSnapshot<MessageData> item) {
    if (item != null) {
      MessageData data = MessageData.fromDocument(item);
      // if (data.idTo == currentUserId.toString()) {
      //   return SizedBox.shrink();
      // } else {
      // return GestureDetector(
      //   onTap: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) {
      //           return ChatDetailPage(
      //             arguments: ChatPageArguments(
      //                 peerId: data.idTo.toString(),
      //                 peerAvatar: data.avatarTo,
      //                 peerNickname: data.nameTo),
      //           );
      //         },
      //       ),
      //     );
      //   },
      //   child: Container(
      //     padding:
      //         const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      //     child: Row(
      //       children: <Widget>[
      //         Expanded(
      //           child: Row(
      //             children: <Widget>[
      //               CircleAvatar(
      //                 backgroundImage: NetworkImage(data.avatarTo),
      //                 maxRadius: 30,
      //               ),
      //               const SizedBox(width: 16),
      //               Expanded(
      //                 child: Container(
      //                   color: Colors.transparent,
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: <Widget>[
      //                       Text(data.nameTo),
      //                       const SizedBox(height: 6),
      //                       Text(
      //                         data.typeContent == 0
      //                             ? data.lastContent
      //                             : data.typeContent == 2
      //                                 ? '[Sticker]'
      //                                 : '[Hình ảnh]',
      //                         style: TextStyle(
      //                             fontSize: 14, color: Colors.grey.shade500),
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //         Text(
      //           TimeUtils().checkOver24Hours(DateFormat('yyyy-MM-dd HH:mm:ss')
      //                   .format(DateTime.parse(data.lastTimestamp)))
      //               ? DateFormat('HH:mm')
      //                   .format(DateTime.parse(data.lastTimestamp))
      //               : DateFormat('dd-MM')
      //                   .format(DateTime.parse(data.lastTimestamp)),
      //           //DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(userChat.timestamp)),
      //           style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
      //         )
      //       ],
      //     ),
      //   ),
      // );
      //}
      return GestureDetector(
        onTap: () {
          var idTo = '';
          var nameTo = '';
          var avatarTo = '';
          if (data.idFrom == currentUserId.toString()) {
            idTo = data.idTo;
            nameTo = data.nameTo;
            avatarTo = data.avatarTo;
          } else {
            idTo = data.idFrom;
            nameTo = data.nameFrom;
            avatarTo = data.avatarFrom;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChatDetailPage(
                  arguments: ChatPageArguments(
                      peerId: idTo, peerAvatar: avatarTo, peerNickname: nameTo),
                );
              },
            ),
          );
        },
        child: Container(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                    data.idFrom == currentUserId.toString()
                        ? data.avatarTo
                        : data.avatarFrom),
                maxRadius: 30,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data.idFrom == currentUserId.toString()
                                ? data.nameTo
                                : data.nameFrom,
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            TimeUtils().checkOver24Hours(
                                    DateFormat('yyyy-MM-dd HH:mm:ss').format(
                                        DateTime.parse(data.lastTimestamp)))
                                ? DateFormat('HH:mm')
                                    .format(DateTime.parse(data.lastTimestamp))
                                : DateFormat('dd-MM')
                                    .format(DateTime.parse(data.lastTimestamp)),
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey.shade500),
                          )
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        data.typeContent == 0
                            ? data.lastContent
                            : data.typeContent == 2
                                ? '[Sticker]'
                                : '[Hình ảnh]',
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 15, color: Colors.grey.shade500),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
