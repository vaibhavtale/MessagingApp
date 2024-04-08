import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/chat/chat_feature.dart';
import 'package:messenger_app/utils/custom_methods.dart';
import 'package:messenger_app/utils/message_container.dart';

class ChatPage extends StatefulWidget {
  final String receiverId;
  final String receiverEmail;

  const ChatPage(
      {super.key, required this.receiverId, required this.receiverEmail});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatFeature _chatFeature = ChatFeature();

  //final _firebase = FirebaseAuth.instance;

  void sendMessage() async {
    try {
      if (_messageController.text.isNotEmpty) {
        await _chatFeature.sendMessage(
            widget.receiverId, _messageController.text.trim());
        _messageController.clear();
      }
    } catch (e) {
      //
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          widget.receiverEmail.toString(),
          style: const TextStyle(fontSize: 16),
        )),
      ),
      body: Stack(
        children: [
          _buildMessageList(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[200],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          controller: _messageController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type Message here..'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      sendMessage();
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blueAccent),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatFeature.getMessage(
            widget.receiverId, FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs
                  .map((document) => _buildMessageItem(document))
                  .toList(),
            );
          }
          return const Text('Got some error');
        });
  }

  Widget _buildMessageItem(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    var alignment = (data['SenderId'] == FirebaseAuth.instance.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    Timestamp timestamp = data['Timestamp'];
    DateTime dateTime = timestamp.toDate();
    String formattedTime = "${dateTime.hour}:${dateTime.minute.toString()}";

    return Container(
        padding: const EdgeInsets.all(8),
        alignment: alignment,
        child: MessageContainer(
          message: data['Message'],
          time: formattedTime,
        ));
  }
}
