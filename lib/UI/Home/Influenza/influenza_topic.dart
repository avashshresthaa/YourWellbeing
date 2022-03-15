import 'dart:convert';
import 'dart:ui';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/APIModels/getCovid.dart';
import 'package:yourwellbeing/APIModels/getInfluenza.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:yourwellbeing/Extracted%20Widgets/buttons.dart';
import 'package:yourwellbeing/Utils/user_prefrences.dart';

class HomeTopicInfluenza extends StatefulWidget {
  HomeTopicInfluenza(this.label, this.indexID, this.list);

  final label;
  var indexID;
  final list;

  @override
  State<HomeTopicInfluenza> createState() => _HomeTopicInfluenzaState();
}

class _HomeTopicInfluenzaState extends State<HomeTopicInfluenza> {
  var language;
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
    language = UserSimplePreferences.getLanguage() ?? true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kStyleBackgroundColor,
      appBar: ProfileAppBar(
        title: widget.label,
      ),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          children: [
            FutureBuilder<Influenza>(
                future: _influenza,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Column(
                        children: const [
                          Text('Loading'),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        AspectRatio(
                          aspectRatio: 8 / 4,
                          child: Container(
                            child: Image.asset(
                              'assets/aboutinfluenza.png',
                              //fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        DescriptionContent(
                          topic: language
                              ? widget.list[widget.indexID].content
                              : widget.list[widget.indexID].contentNe,
                          content:
                              (widget.list[widget.indexID].children.length != 0)
                                  ? language
                                      ? widget.list[widget.indexID].children[0]
                                          .content
                                      : widget.list[widget.indexID].children[0]
                                          .contentNe
                                  : language
                                      ? "No data."
                                      : "दाता छैन.",
                        ),
                      ],
                    );
                  }
                }),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors
              .white, /*
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 6.0,
              offset: const Offset(0, -1),
            )
          ],*/
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.indexID != 0)
              SizedBox(
                width: 92,
                child: PNButton(
                  text: 'Previous',
                  onPress: () {
                    setState(() {
                      widget.indexID--;
                    });
                  },
                  color: Colors.grey,
                ),
              ),
            if (widget.indexID != (widget.list.length - 1) &&
                widget.indexID != 0)
              SizedBox(
                width: 92,
                child: PNButton(
                  text: 'Next',
                  onPress: () {
                    setState(() {
                      widget.indexID++;
                    });
                  },
                  color: Colors.green,
                ),
              ),
            if (widget.indexID == 0)
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 92,
                      child: PNButton(
                        text: 'Next',
                        onPress: () {
                          setState(() {
                            widget.indexID++;
                          });
                        },
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class DescriptionContent extends StatelessWidget {
  final topic;
  final content;

  DescriptionContent({
    this.topic,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                boxShadow,
              ],
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topic,
                  style: kStyleHomeTitle,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  content,
                  style: kStyleHomeTitle.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
