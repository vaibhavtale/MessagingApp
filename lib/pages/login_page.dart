import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messanger_app/utils/auth_container.dart';
import 'package:messanger_app/utils/social_media_buttons.dart';

import '../utils/custom_methods.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _resetPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _resetPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.sizeOf(context).height * 0.13,
              horizontal: MediaQuery.sizeOf(context).width * 0.05),
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(35),
              child: Column(
                children: [
                  const Text(
                    "Messenger",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomTextfield(
                      text: "mobile number, username or email",
                      controller: _emailController),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextfield(
                    text: 'password',
                    controller: _passwordController,
                    obscure: true,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          popUpMessage(context, _resetPasswordController);
                        },
                        child: const Text(
                          'forgot password?',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: CupertinoColors.activeBlue,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: CupertinoColors.activeBlue),
                    ),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const OrWidget(),
                  const SizedBox(
                    height: 15,
                  ),
                  const SocialMediaButton(
                      text: 'Continue with Facebook',
                      icon: Icon(
                        Icons.facebook,
                        color: Colors.blue,
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  const SocialMediaButton(
                      text: 'Continue with Reddit',
                      icon: Icon(
                        Icons.reddit,
                        color: Colors.redAccent,
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  const OrWidget(),
                  const SizedBox(
                    height: 15,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("don't have account? "),
                      Text(
                        'Sign up',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
