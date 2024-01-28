import 'package:flutter/material.dart';

class MessageContainer extends StatelessWidget {
  final String message;
  final String time;
  const MessageContainer(
      {super.key, required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 1),
      decoration: BoxDecoration(
          color: Colors.blue[300], borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            message,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            time,
            style: const TextStyle(
              fontSize: 8,
            ),
          )
        ],
      ),
    );
  }
}
