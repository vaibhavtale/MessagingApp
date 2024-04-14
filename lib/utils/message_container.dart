import 'package:flutter/material.dart';

class MessageContainer extends StatelessWidget {
  final String message;
  final String time;
  final Color foreColor;
  final Color bgColor;
  const MessageContainer(
      {super.key,
      required this.message,
      required this.time,
      required this.foreColor,
      required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 1),
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            message,
            style: TextStyle(color: foreColor, fontSize: 14),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            time,
            style: TextStyle(
              color: foreColor,
              fontSize: 8,
            ),
          )
        ],
      ),
    );
  }
}
