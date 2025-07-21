import 'package:chatapp/pages/chat_bubble.dart';
import 'package:chatapp/pages/cubits/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Chatpage extends StatelessWidget {
  Chatpage({super.key});
  static String id = 'ChatPage';
  final TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)!.settings.arguments as String;

    // Only call getMessages ONCE when the page builds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final chatCubit = BlocProvider.of<ChatCubit>(context);
      if (chatCubit.messageList.isEmpty) {
        chatCubit.getmessages();
      }
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF2B475E),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/scholar.png', height: 60),
            const SizedBox(width: 8),
            const Text('Chats',
                style: TextStyle(fontSize: 24, color: Colors.white)),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                if (state is ChatSuccess) {
                  final messages = state.messages;

                  return ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      return msg.id == email
                          ? Chatbubble(message: msg.messages)
                          : ChatbubbleForFriend(message: msg.messages);
                    },
                  );
                } else if (state is ChatInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Center(child: Text('No messages'));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onSubmitted: (text) {
                if (text.trim().isEmpty) return;
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(message: text.trim(), email: email);
                controller.clear();
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              },
              decoration: InputDecoration(
                hintText: 'Send message',
                suffixIcon: const Icon(Icons.send),
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
