import 'dart:convert';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yourwellbeing/APIModels/getCovid.dart';
import 'package:yourwellbeing/APIModels/getInfluenza.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:yourwellbeing/Extracted%20Widgets/content_list_topic.dart';
import 'influenza_topic.dart';

class AboutPageInfluenza extends StatefulWidget {
  AboutPageInfluenza({this.indexId, this.label});

  final indexId;
  final label;

  @override
  State<AboutPageInfluenza> createState() => _AboutPageInfluenzaState();
}

class _AboutPageInfluenzaState extends State<AboutPageInfluenza> {
  Future<Influenza>? _influenza;

  Future<Influenza> getInfluenzaApiData() async {
    var cacheData = await APICacheManager().getCacheData("influenza");
    var jsonMap = jsonDecode(cacheData.syncData);
    print("cache: hit");
    return Influenza.fromJson(jsonMap);
  }

  @override
  void initState() {
    // TODO: implement initState
    _influenza = getInfluenzaApiData();
    super.initState();
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
            FutureBuilder<Influenza>(
                future: _influenza,
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
                          .influenzaDetails![widget.indexId].children!.length,
                      itemBuilder: (BuildContext context, int index) {
                        var textLabel = snapshot.data!.data!
                            .influenzaDetails![widget.indexId].children![index];
                        return ContentList(
                          text: textLabel.content,
                          page: HomeTopicInfluenza(
                            widget.label,
                            index,
                            snapshot.data!.data!
                                .influenzaDetails![widget.indexId].children,
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
