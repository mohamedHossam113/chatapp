// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Chatbubble extends StatelessWidget {
  Chatbubble({super.key});
  String? message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                bottomRight: Radius.circular(32)),
            color: Color(0xFF2B475E)),
        child: const Text(
          'i am a new user',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
