// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Chatbubble extends StatelessWidget {
  const Chatbubble({super.key, required this.message});
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                bottomLeft: Radius.circular(32)),
            color: Color(0xFF2B475E)),
        child: Text(
          message!,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class ChatbubbleForFriend extends StatelessWidget {
  const ChatbubbleForFriend({super.key, required this.message});
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                bottomRight: Radius.circular(32)),
            color: Colors.cyan),
        child: Text(
          message!,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
