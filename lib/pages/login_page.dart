import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/pages/register_page.dart';
import 'package:messenger_app/utils/auth_container.dart';
import 'package:messenger_app/utils/social_media_buttons.dart';

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
  String? _emailErrorMessage, _errorMessagePassword;
  //final _firebase = FirebaseAuth.instance;

  Future<User?> signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      showMessage(context, 'Signed In successfully.');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        setState(() {
          _emailErrorMessage = 'invalid-email';
        });
      }

      bool _emailExists = (await FirebaseAuth.instance
              .fetchSignInMethodsForEmail(_emailController.text.trim()))
          .isNotEmpty;

      if (!_emailExists) {
        setState(() {
          _errorMessagePassword = 'Incorrect password';
        });
      } else {
        setState(() {
          _emailErrorMessage = 'Incorrect Email';
        });
        setState(() {
          _errorMessagePassword = 'Incorrect password';
        });
      }
      return null;
    } catch (e) {
      showMessage(context, ' ${e.runtimeType}');
    }
    _emailErrorMessage = _errorMessagePassword = null;
    return null;
  }

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
              vertical: MediaQuery.of(context).size.height * 0.13,
              horizontal: MediaQuery.of(context).size.width * 0.05),
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
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomTextfield(
                    text: "username or email",
                    controller: _emailController,
                    errorMessage: _emailErrorMessage,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextfield(
                    text: 'password',
                    controller: _passwordController,
                    errorMessage: _errorMessagePassword,
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
                          popUpMessage(
                            context,
                            _resetPasswordController,
                          );
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
                  GestureDetector(
                    onTap: () => signIn(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: CupertinoColors.activeBlue,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: CupertinoColors.activeBlue,
                        ),
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const OrWidget(),
                  const SizedBox(
                    height: 15,
                  ),
                  const SocialMediaButton(
                      text: 'Continue with Google',
                      icon: Icon(
                        Icons.security,
                        color: Colors.redAccent,
                      )),
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
                  const OrWidget(),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("don't have account? "),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => RegisterPage())),
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
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
