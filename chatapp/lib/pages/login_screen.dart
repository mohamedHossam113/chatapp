// ignore_for_file: use_build_context_synchronously

import 'package:chatapp/pages/Chat_page.dart';
import 'package:chatapp/pages/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'registeration_page.dart';
import 'custom_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: const Color(0xFF2B475E),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .85,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 2),
                      Image.asset('assets/images/scholar.png'),
                      const Text(
                        'Scholar Chat',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'pacifico',
                        ),
                      ),
                      const SizedBox(height: 50),
                      const Row(
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CustomWidget(
                        onChanged: (data) {
                          email = data;
                        },
                        hintText: 'Email',
                      ),
                      const SizedBox(height: 20),
                      CustomWidget(
                        onChanged: (data) {
                          password = data;
                        },
                        hintText: 'Password',
                      ),
                      const SizedBox(height: 20),
                      MyButton(
                        text: 'Sign In',
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });

                            final auth = FirebaseAuth.instance;

                            try {
                              await auth.signInWithEmailAndPassword(
                                email: email!,
                                password: password!,
                              );

                              await loginUser(); // optional user-specific logic

                              if (!mounted) return;

                              Navigator.pushNamed(context, Chatpage.id,
                                  arguments: email);
                            } on FirebaseAuthException catch (_) {
                              if (!mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Invalid email or password'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } catch (_) {
                              if (!mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('An unexpected error occurred'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } finally {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Dont have an account?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterationPage(),
                                ),
                              );
                            },
                            child: const Text(
                              "   Register",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
