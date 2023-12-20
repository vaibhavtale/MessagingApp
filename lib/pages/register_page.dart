import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messanger_app/utils/custom_methods.dart';

import '../utils/auth_container.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  bool? isChecked = false;

  Future<void> signUp() async {
    CollectionReference users = FirebaseFirestore.instance.collection('User');
    QuerySnapshot querySnapshot = await users
        .where('username', isEqualTo: _userNameController.text.trim())
        .get();

    if (querySnapshot.docs.isNotEmpty)
      showMessage(context, "Username already Exists.");

    // it should terminate here...

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      String uid = userCredential.user!.uid;

      Map<String, dynamic> userData = {
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'username': _userNameController.text.trim(),
        'password': _passwordController.text.trim()
      };

      FirebaseFirestore.instance.collection('User').doc(uid).set(userData);
      showMessage(context, "You have Successfully Registered..");
    } catch (e) {
      showMessage(context, "Something went wrong..");
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.sizeOf(context).height * 0.10,
              horizontal: MediaQuery.sizeOf(context).width * 0.05),
          child: Column(
            children: [
              Container(
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
                        height: 30,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sign up to see photos and videos ',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.grey.shade600,
                                fontSize: 16),
                          ),
                          Text(
                            'from your friends.',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.grey.shade600,
                                fontSize: 16),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: CupertinoColors.activeBlue,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.facebook,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                'Log in with Facebook',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextfield(
                        text: "Mobile number, username or email",
                        controller: _emailController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextfield(
                        text: ' Name ',
                        controller: _nameController,
                        obscure: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextfield(
                        text: 'Username',
                        controller: _userNameController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextfield(
                        text: 'Password',
                        controller: _passwordController,
                        obscure: true,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Some Logic to be Implemented Here....
                          Checkbox(
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value;
                              });
                            },
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SmallText(
                                  text:
                                      "By signing up you agree to our terms,"),
                              SmallText(
                                  text: "privacy policy and cookies policy.")
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () => signUp(),
                        child: Container(
                          decoration: BoxDecoration(
                            color: CupertinoColors.activeBlue,
                            borderRadius: BorderRadius.circular(30),
                            border:
                                Border.all(color: CupertinoColors.activeBlue),
                          ),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 18),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Have an account? "),
                      Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SmallText extends StatelessWidget {
  final String text;

  const SmallText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w700),
    );
  }
}
