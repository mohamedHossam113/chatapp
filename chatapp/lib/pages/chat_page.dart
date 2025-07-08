import 'package:chatapp/pages/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chatpage extends StatelessWidget {
  Chatpage({super.key});
  static String id = 'ChatPage';
  final CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: messages.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data!.docs[0]['messages']);

            return Scaffold(
              //test
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: const Color(0xFF2B475E),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/scholar.png',
                      height: 60,
                    ),
                    const Text(
                      'Chats',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Chatbubble();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add({'messages': data});
                        controller.clear();
                      },
                      decoration: InputDecoration(
                        hintText: 'Send message',
                        suffixIcon: const Icon(Icons.send),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Text('Loading..');
          }
        });
  }
}
