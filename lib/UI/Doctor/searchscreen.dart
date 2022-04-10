import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yourwellbeing/APIModels/getDoctorInfo.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:yourwellbeing/Extracted%20Widgets/doctorinfo.dart';
import 'package:yourwellbeing/Network/NetworkHelper.dart';
import 'package:yourwellbeing/Services/constants.dart';
import 'package:yourwellbeing/Services/database.dart';
import '../Chat/conversationscreen.dart';
import 'doctorprofile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';

  TextEditingController searchTextEditingController = TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();

  QuerySnapshot? searchSnapshot;

  initiateSearch() {
    databaseMethods
        .getUserByUsername(searchTextEditingController.text)
        .then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  //Create a chatroom, send user to the conservation screen
  createChatRoomAndStartConversation({required String userName}) {
    if (userName != Constants.myName) {
      String chatRoomId = getChatRoomId(userName, Constants.myName);
      List<String?> users = [userName, Constants.myName];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatRoomId,
      };

      databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConversationScreen(chatRoomId),
          ));
    } else {
      print("You cannot send message yourself");
    }
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(
                userName: searchSnapshot?.docs[index].get("name"),
                userEmail: searchSnapshot?.docs[index].get("email"),
              );
            },
            itemCount: searchSnapshot?.docs.length,
          )
        : Container();
  }

  Widget SearchTile({required String userName, required String userEmail}) {
    return Container(
      margin: EdgeInsets.only(
        top: 16,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [boxShadow],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name: $userName"),
              SizedBox(
                height: 8,
              ),
              Text("Email: $userEmail"),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              createChatRoomAndStartConversation(userName: userName);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Text(
                "Message",
                style: kStyleHomeTitle.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

/*  Future<DoctorInfo>? _doctorInfo;*/

  Future<DoctorInfo>? getDoctorData() async {
    var data = await NetworkHelper().getDoctorInfoData();
    return data;
  }

  List<DoctorInfo> books = [];

  @override
  void initState() {
    // TODO: implement initState
    initiateSearch();
    init();
/*    _doctorInfo = getDoctorData();*/
    super.initState();
  }

  Future init() async {
    final books = await NetworkHelper().getDoctor(query);
    setState(() {
      this.books = books;
    });
  }

  Future searchBook(String query) async {
    NetworkHelper networkHelper = NetworkHelper();
    final books = await networkHelper.getDoctor(query);

    if (!mounted) return;

    setState(() {
      this.query = query;
      this.books = books;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kStyleBackgroundColor,
      appBar: ProfileAppBar(title: 'Doctors'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CupertinoSearchTextField(
              controller: searchTextEditingController,
              onChanged: (query) {
                searchBook(query);
              },
              /*    onTap: () {
                */ /*   initiateSearch();*/ /*
              },*/
            ),
            /*  searchList(),*/
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: books.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    var detail = books[index];
                    var details = books;

                    var doctorName = detail.name;
                    var speciality = detail.speciality;
                    var rating = detail.ratings;

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DoctorProfile(index: index, details: details);
                        }));
                      },
                      child: DoctorInfoList(
                        doctorName: doctorName,
                        speciality: speciality,
                        rating: rating,
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

// It creates two unique id for user and another user
getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
