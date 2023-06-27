import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_chat_app/controllers/auth.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:new_chat_app/controllers/image_picker_controller.dart';
import 'package:new_chat_app/controllers/messages_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widgets/bubble_message.dart';

class ChatPage extends StatelessWidget {
  final Auth auth = Auth();
  final Messages messages = Messages();
  final TextEditingController _message = TextEditingController();

  void clearTextField() {
    _message.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chat'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              auth.loggedOut(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                reverse: true,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                children: [
                  StreamBuilder<QuerySnapshot>(
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      List<Widget> messageWidgets = [];
                      final messages = snapshot.data?.docs;

                      for (var message in messages!) {
                        final sender = message.get('sender');
                        final textMessage = message.get('message');
                        final creationDate = message.get('date').toDate();
                        final widgetId = message.id;

                        final messageWidget = Row(
                          mainAxisAlignment: sender == auth.user!.email
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            BubbleMessage(
                                sender: sender,
                                auth: auth,
                                textMessage: textMessage),
                          ],
                        );
                        messageWidgets.add(messageWidget);
                      }
                      return Column(
                        children: messageWidgets,
                      );
                    },
                    stream: messages.db
                        .collection('messages')
                        .orderBy('date')
                        .snapshots(),
                  )
                ],
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    context.read<PickingImageController>().makePhoto();
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Icon(
                      MdiIcons.camera,
                      color: Theme.of(context).primaryColor,
                      size: 30,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Icon(
                    MdiIcons.image,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 35,
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                    child: TextField(
                      controller: _message,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        filled: true,
                        fillColor:
                            Theme.of(context).inputDecorationTheme.fillColor,
                        hintText: 'Type your message...',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    if (_message.text.trim().isNotEmpty) {
                      messages.sendMessage(_message.text);
                      clearTextField();
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(
                      MdiIcons.send,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
