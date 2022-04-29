import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:yourwellbeing/Extracted%20Widgets/customtextfield.dart';
import 'package:yourwellbeing/Services/constants.dart';
import 'package:yourwellbeing/Services/database.dart';
import 'package:yourwellbeing/Constraints/uppercase.dart';
import 'package:timeago/timeago.dart' as timeago;

class ConversationScreen extends StatefulWidget {
  final chatRoomId;
  final String? userName;

  ConversationScreen(this.chatRoomId, this.userName);

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
                  var time = snapshot.data?.docs[index].get("time");
                  var datetime =
                      DateTime.fromMicrosecondsSinceEpoch(time).toString();
                  DateTime time1 = DateTime.parse(datetime);
                  var timeAgo = timeago.format(time1).toString();
                  print(timeAgo);
                  return MessageTile(
                    snapshot.data?.docs[index].get("message"),
                    snapshot.data?.docs[index].get("sendBy") ==
                        Constants.myName,
                    timeAgo,
                  );
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
    var titleName = widget.userName.toString().toTitleCase();

    return Scaffold(
      appBar: ProfileAppBar(title: titleName),
      body: Container(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: ChatMessageList(),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: ChatField(
                hintText: 'Write you message',
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
  final String time;
  MessageTile(this.message, this.isSendByMe, this.time);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
            left: isSendByMe ? MediaQuery.of(context).size.width * 0.5 : 16,
            right: isSendByMe ? 16 : MediaQuery.of(context).size.width * 0.5,
          ),
          margin: EdgeInsets.symmetric(vertical: 8),
          width: MediaQuery.of(context).size.width,
          alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              borderRadius: isSendByMe
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                      bottomLeft: Radius.circular(23))
                  : const BorderRadius.only(
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
        ),
        Container(
          padding: EdgeInsets.only(
            left: isSendByMe ? MediaQuery.of(context).size.width * 0.5 : 16,
            right: isSendByMe ? 16 : MediaQuery.of(context).size.width * 0.5,
          ),
          width: MediaQuery.of(context).size.width,
          alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Text(
            time,
            style: kStyleHomeTitle.copyWith(
              fontSize: 10.sp,
              color: kStyleGrey777,
            ),
          ),
        ),
      ],
    );
  }
}
