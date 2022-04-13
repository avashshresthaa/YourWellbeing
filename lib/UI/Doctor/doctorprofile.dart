import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:yourwellbeing/Extracted%20Widgets/buttons.dart';
import 'package:yourwellbeing/Services/constants.dart';
import 'package:yourwellbeing/Services/database.dart';
import 'package:yourwellbeing/UI/Appointment/bookappointment.dart';
import 'package:yourwellbeing/UI/Chat/conversationscreen.dart';
import 'package:yourwellbeing/UI/Doctor/searchscreen.dart';

class DoctorProfile extends StatefulWidget {
  DoctorProfile({this.index, this.details});
  final index;
  final details;

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  DatabaseMethods databaseMethods = DatabaseMethods();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ProfileAppBar(
        title: 'Doctors',
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 70.0),
            child: ListView(
              physics: ScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              children: [
                Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(100)),
                      child: Text(
                        "${widget.details[widget.index].name?.substring(0, 1).toUpperCase()}",
                        style: kStyleHomeTitle.copyWith(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                    child: Text(
                  'Dr. ${widget.details[widget.index].name}',
                  style: kStyleDoctor,
                )),
                const SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    widget.details[widget.index].speciality,
                    style: kStyleDoctor.copyWith(
                      fontSize: 10.sp,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DoctorAchievement(
                      logo: 'assets/years.png',
                      number: widget.details[widget.index].experience,
                      nameType: 'Experience',
                    ),
                    DoctorAchievement(
                      logo: 'assets/ratings.png',
                      number: widget.details[widget.index].ratings,
                      nameType: 'Ratings',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'About Doctor',
                  style: kStyleDoctor,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  '${widget.details[widget.index].about}',
                  textAlign: TextAlign.justify,
                  style: kStyleDoctor.copyWith(
                    fontSize: 11.sp,
                    color: Color(0xFF6B779A),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Working Time',
                  style: kStyleDoctor,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  '${widget.details[widget.index].appointmentTime}',
                  style: kStyleDoctor.copyWith(
                    fontSize: 11.sp,
                    color: Color(0xFF6B779A),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ACButton(
                      'Book Appointment',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookAppointment()),
                        );
                      },
                      kStyleBlue,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: ACButton(
                      'Chat Now',
                      () {
                        createChatRoomAndStartConversation(
                            userName: widget.details[widget.index].name);
                      },
                      Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorAchievement extends StatelessWidget {
  DoctorAchievement({this.logo, this.number, this.nameType});
  final logo;
  final number;
  final nameType;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [boxShadow],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              logo,
              height: 50,
            ),
            SizedBox(height: 17),
            Text('$number', style: kStyleDoctor),
            SizedBox(height: 4),
            Text(
              '$nameType',
              style: kStyleDoctor,
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
