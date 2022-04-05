import 'dart:convert';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yourwellbeing/APIModels/getCovid.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:yourwellbeing/Extracted%20Widgets/content_list_topic.dart';
import 'covid_topic.dart';

class AboutPage extends StatefulWidget {
  AboutPage({this.indexId, this.label});

  final indexId;
  final label;

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  Future<Covid>? _covid;

  Future<Covid> getCovidApiData() async {
    var cacheData = await APICacheManager().getCacheData("covid");
    var jsonMap = jsonDecode(cacheData.syncData);
    print("cache: hit");
    return Covid.fromJson(jsonMap);
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _covid = getCovidApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kStyleBackgroundColor,
      appBar: ProfileAppBar(
        title: widget.label,
      ),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          padding: EdgeInsets.only(
            top: 16,
            right: 16,
            left: 16,
          ),
          children: [
            FutureBuilder<Covid>(
                future: _covid,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      height: 800,
                      child: Shimmer.fromColors(
                        direction: ShimmerDirection.ttb,
                        period: const Duration(milliseconds: 8000),
                        child: ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(16),
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.black,
                                ),
                              );
                            }),
                        baseColor: Color(0xFFE5E4E2),
                        highlightColor: Color(0xFFD6D6D6),
                      ),
                    );
                  }

                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.data!
                          .covidDetails![widget.indexId].children!.length,
                      itemBuilder: (BuildContext context, int index) {
                        var textLabel = snapshot.data!.data!
                            .covidDetails![widget.indexId].children![index];
                        return ContentList(
                          text: textLabel.content,
                          page: HomeTopic(
                            widget.label,
                            index,
                            snapshot.data!.data!.covidDetails![widget.indexId]
                                .children,
                          ),
                        );
                      });
                }),
          ],
        ),
      ),
    );
  }
}
