import 'dart:convert';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/APIModels/getContacts.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yourwellbeing/Network/NetworkHelper.dart';

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
  NetworkHelper networkHelper = NetworkHelper();
  Future<Contacts>? _contacts;

  Future<Contacts>? getContactsLists() async {
    var cacheData = await APICacheManager().getCacheData("contact_numbers");
    var jsonMap = jsonDecode(cacheData.syncData);
    print("cache: hit");
    return Contacts.fromJson(jsonMap);
  }

  @override
  void initState() {
    // TODO: implement initState
    _contacts = getContactsLists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Contacts>(
        future: _contacts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.only(
                  top: 20, left: 16, right: 16, bottom: 6),
              itemCount: snapshot.data?.data?.length,
              itemBuilder: (context, index) {
                var count = snapshot.data?.data![index];
                return ContactContents(
                  location: count?.location,
                  name: count?.name,
                  number: count?.number,
                );
              },
            );
          } else {
            return Container();
          }
        });
  }
}

class ContactContents extends StatelessWidget {
  final location;
  final name;
  final number;

  ContactContents({this.location, this.name, this.number});
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
                          location,
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
                        name,
                        style: kStyleHomeTitle.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                            fontSize: 11.sp),
                      ),
                    ),
                    Text(
                      number,
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
                    launch('tel://${number}');
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
