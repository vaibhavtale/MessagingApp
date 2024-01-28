import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:messenger_app/model/message.dart';

class ChatFeature extends ChangeNotifier {
  // Get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Send message
  Future<void> sendMessage(String receiverId, String message) async {
    // Get current user Info..
    String senderId = _firebaseAuth.currentUser!.uid;
    String senderEmail = _firebaseAuth.currentUser!.email.toString();

    //   Create a new message
    Message newMessage = Message(
      senderId: senderId,
      senderEmail: senderEmail,
      receiverId: receiverId,
      message: message,
      timestamp: Timestamp.now(),
    );

    //   Construct chat room Id from current user id and receiver Id
    List<String> ids = [senderId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    //   Add new Message to database..
    _firestore
        .collection('Chat_room')
        .doc(chatRoomId)
        .collection('Messages')
        .add(
          newMessage.toMap(),
        );
  }
  //Get the messages from firebase firestore.

  Stream<QuerySnapshot> getMessage(String userId, String senderId) {
    List<String> ids = [userId, senderId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection('Chat_room')
        .doc(chatRoomId)
        .collection('Messages')
        .orderBy('Timestamp', descending: false)
        .snapshots();
  }
}
