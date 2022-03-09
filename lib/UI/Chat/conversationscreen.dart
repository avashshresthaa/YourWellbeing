import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/Change%20Notifier/changenotifier.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:yourwellbeing/Extracted%20Widgets/customtextfield.dart';
import 'package:yourwellbeing/Services/constants.dart';
import 'package:yourwellbeing/Services/database.dart';
import 'package:yourwellbeing/Constraints/uppercase.dart';

class ConversationScreen extends StatefulWidget {
  final chatRoomId;

  ConversationScreen(this.chatRoomId);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController messageController = TextEditingController();

  Stream<QuerySnapshot>? chatMessagesStream;

  // For real time chat we have to use stream
  Widget ChatMessageList() {
    return StreamBuilder<QuerySnapshot>(
        stream: chatMessagesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                reverse: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                      snapshot.data?.docs[index].get("message"),
                      snapshot.data?.docs[index].get("sendBy") ==
                          Constants.myName);
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().microsecondsSinceEpoch,
      };
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
      messageController.clear();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    databaseMethods.getConversationMessages(widget.chatRoomId).then((val) {
      setState(() {
        chatMessagesStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var getName = Provider.of<DataProvider>(context, listen: false).otherName;
    var titleName = getName.toString().toTitleCase();

    return Scaffold(
      appBar: MainAppBar(titleName),
      body: Container(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: ChatMessageList(),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: ChatField(
                hintText: 'Message...',
                controller: messageController,
                onTap: () {
                  sendMessage();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  MessageTile(this.message, this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: isSendByMe ? MediaQuery.of(context).size.width * 0.5 : 24,
        right: isSendByMe ? 24 : MediaQuery.of(context).size.width * 0.5,
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          borderRadius: isSendByMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomLeft: Radius.circular(23))
              : BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomRight: Radius.circular(23)),
          gradient: LinearGradient(
              colors: isSendByMe
                  ? [Colors.green, Colors.green.shade400]
                  : [
                      Colors.grey,
                      Colors.grey.shade400,
                    ]),
        ),
        child: Text(
          message,
          style: kStyleHomeTitle.copyWith(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
