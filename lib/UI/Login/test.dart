import 'package:flutter/material.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';

class SelectUser extends StatefulWidget {
  const SelectUser({Key? key}) : super(key: key);

  @override
  State<SelectUser> createState() => _SelectUserState();
}

class _SelectUserState extends State<SelectUser> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Expanded(
              child: Column(
                children: [
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 40,
                          margin: EdgeInsets.symmetric(horizontal: 24),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 2,
                                    spreadRadius: 1,
                                    color: Colors.grey.withOpacity(0.3),
                                    offset: Offset(0, 3))
                              ]),
                          child: TabBar(
                              isScrollable: true,
                              unselectedLabelStyle: TabText,
                              indicator: BoxDecoration(
                                  color: kStyleMainGrey,
                                  borderRadius: BorderRadius.circular(4)),
                              labelColor: Colors.white,
                              labelStyle: TabText,
                              unselectedLabelColor: kStyleMainGrey,
                              // Tabbar tabs
                              tabs: [
                                TabBarTabs(
                                  text: 'Customer',
                                ),
                                TabBarTabs(text: 'Driver')
                              ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Container(
                          height: 250,
                          child: TabBarView(children: [
                            Container(
                              color: Colors.red,
                            ),
                            Container(
                              color: Colors.black,
                            ),
                          ]),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabBarTabs extends StatelessWidget {
  String text;

  TabBarTabs({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      child: Padding(
        padding: EdgeInsets.only(left: 8, right: 8.0),
        child: Center(
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}

const TabText = const TextStyle(
  fontFamily: 'NunitoSans',
  fontSize: 14.4,
);
