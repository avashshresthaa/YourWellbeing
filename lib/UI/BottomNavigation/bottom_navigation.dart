import 'package:flutter/material.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/showdialog.dart';
import 'package:yourwellbeing/UI/Home/home.dart';
import '../Appointment/appointment.dart';
import '../Chat/chat.dart';
import '../Settings/settings.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _currentIndex = 0;

  final _children = [
    const MainDashboard(),
    const Appointment(),
    const Chat(),
    const Settings(),
  ];

  void _onChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final items = <Widget>[
    const Icon(
      Icons.home,
      size: 25,
    ),
    const Icon(
      Icons.calendar_today,
      size: 22,
    ),
    const Icon(
      Icons.forum,
      size: 22,
    ),
    const Icon(
      Icons.settings,
      size: 22,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex == 0) {
          await showBackDialog(context);
        } else if (_currentIndex != 0) {
          _onChanged(0);
        }
        return false;
      },
      child: Container(
        color: Colors.white,
        child: SafeArea(
          top: false,
          child: ClipRect(
            child: Scaffold(
              extendBody: true,
              backgroundColor: kStyleBackgroundColor,
              resizeToAvoidBottomInset: false,
              body: _children[_currentIndex],
              bottomNavigationBar: Theme(
                data: Theme.of(context).copyWith(
                  iconTheme: const IconThemeData(color: Colors.green),
                ),
                child: CurvedNavigationBar(
                  index: _currentIndex,
                  backgroundColor: Colors.transparent,
                  height: 55,
                  animationCurve: Curves.easeIn,
                  animationDuration: const Duration(milliseconds: 300),
                  items: items,
                  onTap: _onChanged,
                  //type: BottomNavigationBarType.fixed,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
