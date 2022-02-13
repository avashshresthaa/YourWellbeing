import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:url_launcher/url_launcher.dart';
import 'contactlist.dart';

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({Key? key}) : super(key: key);

  @override
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kStyleBackgroundColor,
      appBar: ProfileAppBar(title: 'Emergency Contacts'),
      body: const EmergencyContent(),
    );
  }
}

class EmergencyContent extends StatefulWidget {
  const EmergencyContent({Key? key}) : super(key: key);

  @override
  _EmergencyContentState createState() => _EmergencyContentState();
}

class _EmergencyContentState extends State<EmergencyContent> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 6),
      itemCount: ContactModel.contacts.length,
      itemBuilder: (context, index) {
        return ContactContents(
          item: ContactModel.contacts[index],
        );
      },
    );
  }
}

class ContactContents extends StatelessWidget {
  final Contacts item;

  const ContactContents({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 14.0,
      ),
      child: Container(
        height: 65.sp,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            boxShadow,
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomLeft: Radius.circular(6),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: kStyleCoolGrey,
                          size: 20,
                        ),
                        Text(
                          item.location,
                          style: kStyleHomeTitle.copyWith(
                              color: kStyleCoolGrey,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        item.name,
                        style: kStyleHomeTitle.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                            fontSize: 11.sp),
                      ),
                    ),
                    Text(
                      item.number,
                      style: kStyleHomeTitle.copyWith(
                          fontWeight: FontWeight.w400, fontSize: 10.sp),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    launch('tel://${item.number}');
                  },
                  child: const Icon(
                    Icons.phone_outlined,
                    color: kStyleCoolGrey,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
