import 'package:flutter/material.dart';

import '../controllers/auth.dart';

class BubbleMessage extends StatelessWidget {
  final String sender;
  final Auth auth;
  final String textMessage;
  const BubbleMessage({
    super.key,
    required this.sender,
    required this.auth,
    required this.textMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Material(
        color: sender != auth.user!.email
            ? Theme.of(context).cardColor
            : Theme.of(context).highlightColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(5),
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            '$textMessage',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
