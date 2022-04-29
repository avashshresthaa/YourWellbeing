import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:yourwellbeing/Extracted%20Widgets/snackbar.dart';
import 'package:yourwellbeing/Services/authentication.dart';
import 'package:yourwellbeing/Services/constants.dart';
import 'package:yourwellbeing/Services/database.dart';
import 'package:yourwellbeing/View/Chat/conversationscreen.dart';
import 'package:yourwellbeing/View/Doctor/searchscreen.dart';
import 'package:yourwellbeing/Utils/user_prefrences.dart';
import '../Login/loginpermission.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  var loginData;

  @override
  void initState() {
    //sharedPreferenceLogin();
    // TODO: implement initState
    super.initState();
    loginData = UserSimplePreferences.getLogin() ?? 'guest';
    print(loginData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kStyleBackgroundColor,
      appBar: SChatAppBar(
        title: 'Chat',
        onTap: () {
          loginData == 'guest'
              ? showSnackBar(
                  context,
                  "Attention",
                  Colors.red,
                  Icons.info,
                  "Login Required",
                )
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ));
        },
      ),
      body: loginData == 'guest' ? const SignUpContent() : const ChatRoom(),
    );
  }
}

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  Stream<QuerySnapshot>? chatRoomsStream;

  Widget chatRoomList() {
    return StreamBuilder<QuerySnapshot>(
      stream: chatRoomsStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                      snapshot.data?.docs[index]
                          .get("chatroomId")
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(Constants.myName, ""),
                      snapshot.data?.docs[index].get("chatroomId"));
                },
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator.adaptive(),
                      SizedBox(height: 12),
                      Text(
                        'Please wait...',
                        style: kStyleHomeTitle.copyWith(
                            color: kStyleGrey333, fontSize: 10.sp),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
    // TODO: implement initState
    super.initState();
  }

  getUserInfo() {
    Constants.myName = UserSimplePreferences.getUserName() ?? "";
    databaseMethods.getChatRooms(Constants.myName).then((val) {
      setState(() {
        chatRoomsStream = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kStyleBackgroundColor,
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            'My Chats',
            style: kStyleHomeTitle,
          ),
          const SizedBox(
            height: 16,
          ),
          chatRoomList(),
        ],
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String? userName;
  final String chatRoomId;
  ChatRoomsTile(this.userName, this.chatRoomId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ConversationScreen(chatRoomId, userName ?? 'Chat')),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.sp),
          color: Colors.white,
          boxShadow: [
            boxShadow,
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(40)),
              child: Text(
                "${userName?.substring(0, 1).toUpperCase()}",
                style: kStyleHomeTitle.copyWith(
                  color: Colors.white,
                  fontSize: 12.sp,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName!,
                  style: kStyleHomeTitle.copyWith(
                    color: kStyleGrey333,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Tap to chat here",
                  style: kStyleHomeTitle.copyWith(
                    color: kStyleGrey333,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
