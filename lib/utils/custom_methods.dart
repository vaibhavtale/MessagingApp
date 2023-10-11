import 'package:flutter/material.dart';

import 'auth_container.dart';

popUpMessage(BuildContext context, TextEditingController controller) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Reset Password",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Email will be sent with a \nlink please follow that to \nreset password.",
            ),
            const SizedBox(
              height: 35,
            ),
            CustomTextfield(text: 'email', controller: controller)
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              "cancel",
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "send link",
            ),
          )
        ],
      ),
    );
