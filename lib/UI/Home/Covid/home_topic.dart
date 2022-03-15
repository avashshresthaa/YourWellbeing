import 'dart:convert';
import 'dart:ui';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/APIModels/getCovid.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:yourwellbeing/Extracted%20Widgets/buttons.dart';
import 'package:yourwellbeing/Utils/user_prefrences.dart';

class HomeTopic extends StatefulWidget {
  HomeTopic(this.label, this.indexID, this.list);

  final label;
  var indexID;
  final list;

  @override
  State<HomeTopic> createState() => _HomeTopicState();
}

class _HomeTopicState extends State<HomeTopic> {
  var language;
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
    language = UserSimplePreferences.getLanguage() ?? true;
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
            FutureBuilder<Covid>(
                future: _covid,
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
                              'assets/aboutcovid.png',
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
