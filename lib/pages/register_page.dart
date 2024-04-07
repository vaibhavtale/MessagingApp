import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/utils/custom_methods.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

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
  String? _errorMessageEmail,
      _errorMessageName,
      _errorMessageUsername,
      _errorMessagePassword;

  Future<void> signUp() async {

    _errorMessageEmail = _errorMessageName =
    _errorMessagePassword = _errorMessageUsername = _errorMessagePassword =  null;

    // Checking for Unique Username..
    CollectionReference users = FirebaseFirestore.instance.collection('User');
    QuerySnapshot querySnapshot = await users
        .where('username', isEqualTo: _userNameController.text.trim())
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      //showMessage(context, "Username already Exists.");
      setState(() {
        _errorMessageUsername = "Username already exists..";
      });
      return;
    }

    // Name Field should not be Empty..
    if (_nameController.text.trim() == '') {
      setState(() {
        _errorMessageName = 'Name field Cannot be Empty..';
      });
      return;
    }

    // Agreement has been Signed..
    if (isChecked == false) {
      showMessage(context, 'Please Sign the Agreement.');
      return;
    }

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
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      


      if (e.code == 'invalid-email') {
        setState(() {
          _errorMessageEmail = 'Invalid Email';
        });
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          _errorMessageEmail = 'Email is already in use';
        });
      } else if (e.code == 'weak-password') {
        setState(() {
          _errorMessagePassword = 'Use Strong Password least 8 char.';
        });
      } else {
        showMessage(context, '${e.message}');
      }
    } catch (e) {
      showMessage(context, e.toString());
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
                      GradientText(
                        "Messenger",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 35,
                        ),
                        colors: const [
                          Colors.pinkAccent,
                          Colors.redAccent,
                          Colors.orangeAccent
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Register to see photos and videos ',
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
                                'Sign up with Facebook',
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
                        text: "Email",
                        controller: _emailController,
                        errorMessage: _errorMessageEmail,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextfield(
                        text: ' Name ',
                        controller: _nameController,
                        errorMessage: _errorMessageName,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextfield(
                        text: 'Username',
                        controller: _userNameController,
                        errorMessage: _errorMessageUsername,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextfield(
                        text: 'Password',
                        controller: _passwordController,
                        errorMessage: _errorMessagePassword,
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Have an account? "),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
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
        fontSize: 12,
        color: Colors.grey[600],
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
