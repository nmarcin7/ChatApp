import 'package:flutter/material.dart';
import 'package:new_chat_app/controllers/auth.dart';
import 'package:new_chat_app/widgets/login_button.dart';
import 'package:new_chat_app/widgets/long_text_field.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoginTextField(
              labelText: 'Username',
              icon: Icons.verified_user,
              isObscure: false,
              textController: username),
          const SizedBox(
            height: 10,
          ),
          LoginTextField(
            labelText: 'Email',
            icon: Icons.email,
            textController: email,
          ),
          const SizedBox(
            height: 10,
          ),
          LoginTextField(
            labelText: 'Password',
            icon: Icons.lock,
            isObscure: true,
            textController: password,
          ),
          const SizedBox(
            height: 5,
          ),
          LoginButton(
            onTap: () {
              auth.registerUser(context, email, password, username);
            },
            buttonText: 'Register',
            icon: null,
          )
        ],
      ),
    );
  }
}
