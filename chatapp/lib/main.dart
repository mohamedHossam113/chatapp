import 'package:chatapp/pages/Chat_page.dart';
import 'package:chatapp/pages/login_screen.dart';
import 'package:chatapp/pages/registeration_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.id: (context) => const LoginScreen(),
        RegisterationPage.id: (context) => const RegisterationPage(),
        Chatpage.id: (context) => Chatpage(),
      },
      initialRoute: 'LoginPage',
      home: const LoginScreen(),
    );
  }
}
