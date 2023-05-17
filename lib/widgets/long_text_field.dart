import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_chat_app/constants.dart';

class LoginTextField extends StatelessWidget {
  final String? labelText;
  final IconData? icon;
  final bool isObscure;
  TextEditingController? textController = TextEditingController();

  final Function(String value)? onChanged;

  LoginTextField({
    this.labelText,
    this.icon,
    this.isObscure = false,
    this.onChanged,
    this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        keyboardAppearance: Brightness.dark,
        controller: textController,
        onChanged: onChanged,
        obscureText: isObscure,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: CupertinoColors.activeBlue),
          label: Text(
            labelText!,
            style:
                TextStyle(fontSize: 14, color: Colors.grey, letterSpacing: 0.5),
          ),
          prefixIcon: Icon(
            icon,
            size: 20,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
