import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:washouse_customer/resource/models/chat_user.dart';

import '../../components/constants/firestore_constants.dart';
import '../models/chat_message.dart';

class ChatProvider {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  ChatProvider(
      {required this.firebaseFirestore,
      required this.prefs,
      required this.firebaseStorage});

  String? getPref(String key) {
    return prefs.getString(key);
  }

  UploadTask uploadFile(File image, String fileName) {
    Reference reference = firebaseStorage.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask;
  }

  Future<void> updateDataFirestore(
      String docPath, Map<String, dynamic> dataNeedUpdate) {
    return firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(docPath)
        .update(dataNeedUpdate);
  }

  // Stream<QuerySnapshot> getStreamFireStore(String pathCollection, int limit,
  //     String? textSearch, String currrentUserId) {
  //   if (textSearch?.isNotEmpty == true) {
  //     return firebaseFirestore
  //         .collection(pathCollection)
  //         .doc(currrentUserId)
  //         .collection(currrentUserId)
  //         .limit(limit)
  //         .where(FirestoreConstants.name, isEqualTo: textSearch!)
  //         .snapshots();
  //   } else {
  //     return firebaseFirestore
  //         .collection(pathCollection)
  //         .doc(currrentUserId)
  //         .collection(currrentUserId)
  //         .limit(limit)
  //         .snapshots();
  //   }
  // }

  Stream<QuerySnapshot> getStreamFireStore(String pathCollection, int limit,
      String? textSearch, String groupChatId) {
    if (textSearch?.isNotEmpty == true) {
      return firebaseFirestore
          .collection(pathCollection)
          .limit(limit)
          .where(FirestoreConstants.nameFrom, arrayContains: textSearch)
          .where(FirestoreConstants.nameTo, arrayContains: textSearch)
          .snapshots();
    } else {
      return firebaseFirestore
          .collection(pathCollection)
          .limit(limit)
          .snapshots();
    }
  }

  Stream<QuerySnapshot> getChatStream(String groupChatId, int limit) {
    return firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .collection('msglist')
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .limit(limit)
        .snapshots();
  }

  void sendMessage(String content, int type, String groupChatId,
      String currentUserId, String peerId) {
    DocumentReference documentReference = firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .collection('msglist')
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    MessageChat messageChat = MessageChat(
      idFrom: currentUserId,
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      type: type,
    );

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        messageChat.toJson(),
      );
    });
  }
}

class TypeMessage {
  static const text = 0;
  static const image = 1;
  static const sticker = 2;
}
