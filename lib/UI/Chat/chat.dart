import 'package:flutter/material.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import '../Login/loginpermission.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kStyleBackgroundColor,
      appBar: MainAppBar('Chat'),
      body: const ChatContent(),
    );
  }
}

class ChatContent extends StatefulWidget {
  const ChatContent({Key? key}) : super(key: key);

  @override
  _ChatContentState createState() => _ChatContentState();
}

class _ChatContentState extends State<ChatContent> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SignUpContent(),
      ],
    );
  }
}
