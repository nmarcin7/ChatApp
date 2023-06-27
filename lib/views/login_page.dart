import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:new_chat_app/controllers/auth.dart';
import 'package:new_chat_app/controllers/theme_controller.dart';
import 'package:new_chat_app/widgets/long_text_field.dart';
import 'package:provider/provider.dart';

import '../widgets/login_button.dart';

class LoginPage extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Switch(
            value: context.watch<ThemeController>().toggleTheme,
            onChanged: (value) {
              context.read<ThemeController>().toggleThemeUi();
            },
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoginTextField(
            icon: Icons.email,
            labelText: 'Email',
            isObscure: false,
            textController: email,
          ),
          const SizedBox(
            height: 10,
          ),
          LoginTextField(
            icon: Icons.lock,
            labelText: 'Password',
            isObscure: true,
            textController: password,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Dont have an account?',
                // style: Theme.of(context).textTheme.bodySmall,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'registerPage');
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          LoginButton(
            onTap: () {
              _auth.loggIn(email, password, context);
            },
            buttonText: 'Log in',
            icon: CupertinoIcons.forward,
          ),
        ],
      ),
    );
  }
}
