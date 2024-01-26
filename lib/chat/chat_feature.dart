import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatFeature {
  // Get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Send message
  Future<void> sendMessage(String receiverId, String message) async {
    // Get current user Info..

    //   Create a new message

    //   Construct chat room Id from current user id and receiver Id

    //   Add new Message to database..
  }
}
