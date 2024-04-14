import 'package:flutter/material.dart';
import 'package:messenger_app/pages/chat_page.dart';

class MobileView extends StatelessWidget {
  const MobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChatPage(
        receiverId: "KrK2WHfOXER8wHo8VZcWtmYDOxm1",
        receiverEmail: "pranav@gmail.com");
  }
}
