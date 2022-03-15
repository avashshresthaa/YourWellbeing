import 'dart:convert';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/APIModels/getCovid.dart';
import 'package:yourwellbeing/APIModels/getInfluenza.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';
import 'package:yourwellbeing/Constraints/uppercase.dart';
import 'package:yourwellbeing/Extracted%20Widgets/appbars.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:yourwellbeing/Extracted%20Widgets/homecontents.dart';
import 'package:yourwellbeing/Utils/user_prefrences.dart';
import '../../Constraints/nplanguage.dart';
import '../../Extracted Widgets/showdialog.dart';
import 'Covid/home_content.dart';
import 'Influenza/influenza_content.dart';

var language;
var username;
var loginData;
var purpose;

class MainDashboard extends StatefulWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    language = UserSimplePreferences.getLanguage() ?? true;
    username = UserSimplePreferences.getUserName() ?? "User";
    loginData = UserSimplePreferences.getLogin() ?? 'guest';
    purpose = UserSimplePreferences.getPurpose();
    print(purpose);
    print(username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kStyleBackgroundColor,
      appBar: MainAppBar(language ? 'Home' : nepHome),
      body: const MainContent(),
    );
  }
}

class MainContent extends StatefulWidget {
  const MainContent({Key? key}) : super(key: key);

  @override
  _MainContentState createState() => _MainContentState();
}

// Function that returns greetings according to the Date time
String greetingMessage() {
  var timeNow = DateTime.now().hour;

  if (timeNow <= 11) {
    return 'Good Morning';
  } else if ((timeNow >= 12) && (timeNow <= 16)) {
    return 'Good Afternoon';
  } else if ((timeNow > 16) && (timeNow < 20)) {
    return 'Good Evening';
  } else {
    return 'Good Night';
  }
}

String greetingMessageNP() {
  var timeNow = DateTime.now().hour;

  if (timeNow <= 11) {
    return nepGoodM;
  } else if ((timeNow >= 12) && (timeNow <= 16)) {
    return nepGoodA;
  } else if ((timeNow > 16) && (timeNow < 20)) {
    return nepGoodE;
  } else {
    return nepGoodN;
  }
}

String greetingText = greetingMessage();
String greetingTextNP = greetingMessageNP();

class _MainContentState extends State<MainContent> {
  final urlImages = [
    'assets/Slider/covidbanner.png',
    'assets/Slider/tbbanner.png'
  ];
  final adImages = ['assets/Slider/adphoto.png'];
  var titleName = username.toString().toTitleCase();
  var titlePurpose = purpose.toString().toTitleCase();

  Future<Covid>? _covid;
  Future<Influenza>? _influenza;

  Future<Covid> getCovidApiData() async {
    var cacheData = await APICacheManager().getCacheData("covid");
    var jsonMap = jsonDecode(cacheData.syncData);
    print("cache: hit");
    return Covid.fromJson(jsonMap);
  }

  Future<Influenza> getInfluenzaApiData() async {
    var cacheData = await APICacheManager().getCacheData("influenza");
    var jsonMap = jsonDecode(cacheData.syncData);
    print("cache: hit");
    return Influenza.fromJson(jsonMap);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _covid = getCovidApiData();
    _influenza = getInfluenzaApiData();
  }

  var imagesCovid = [
    'assets/aboutcovid.png',
    'assets/faq.png',
  ];

  var imagesInfluenza = [
    'assets/aboutinfluenza.png',
    'assets/faq.png',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        //This Widget Contains Greeting Text and Slider
        headerContent(),
        const SizedBox(height: 12),
        //This Column Contains Ad Image, My Recent Order and Product Desc
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              myAppointment(),
              const SizedBox(height: 16),
              adContents(),
              const SizedBox(height: 24),
              Text(
                'Learn About $titlePurpose',
                style: kStyleHomeTitle.copyWith(fontSize: 12.sp),
              ),
              const SizedBox(height: 16),
              purpose == 'covid'
                  ? FutureBuilder<Covid>(
                      future: _covid,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container(
                            height: 800,
                            child: Shimmer.fromColors(
                              direction: ShimmerDirection.ttb,
                              period: const Duration(milliseconds: 8000),
                              child: ListView.builder(
                                  itemCount: 2,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.all(16),
                                      height: 160,
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
                        } else {
                          return Column(
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      snapshot.data!.data!.covidDetails!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var textContent = snapshot
                                        .data!.data!.covidDetails![index];
                                    return HomeContents(
                                      text: language
                                          ? textContent.content
                                          : textContent.contentNe,
                                      image: index > imagesCovid.length - 1
                                          ? 'assets/aboutcovid.png'
                                          : imagesCovid[index],
                                      page: AboutPage(
                                        indexId: index,
                                        label: language
                                            ? textContent.content
                                            : textContent.contentNe,
                                      ),
                                    );
                                  }),
                            ],
                          );
                        }
                      })
                  : FutureBuilder<Influenza>(
                      future: _influenza,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container(
                            height: 800,
                            child: Shimmer.fromColors(
                              direction: ShimmerDirection.ttb,
                              period: const Duration(milliseconds: 8000),
                              child: ListView.builder(
                                  itemCount: 2,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 160,
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
                        } else {
                          return Column(
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot
                                      .data!.data!.influenzaDetails!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var textContent = snapshot
                                        .data!.data!.influenzaDetails![index];
                                    return HomeContents(
                                      text: language
                                          ? textContent.content
                                          : textContent.contentNe,
                                      image: index > imagesInfluenza.length - 1
                                          ? 'assets/aboutinfluenza.png'
                                          : imagesInfluenza[index],
                                      page: AboutPageInfluenza(
                                        indexId: index,
                                        label: language
                                            ? textContent.content
                                            : textContent.contentNe,
                                      ),
                                    );
                                  }),
                            ],
                          );
                        }
                      }),
            ],
          ),
        ),
      ],
    );
  }

  Widget headerContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Text(
            language
                ? "$greetingText, $titleName"
                : "$greetingTextNP, $titleName",
            style: kStyleHomeTitle,
          ),
        ),
        const SizedBox(height: 16),
        CarouselSlider.builder(
          itemCount: urlImages.length,
          options: CarouselOptions(
            /*height: 160.sp,*/
            aspectRatio: 10 / 5,
            autoPlay: true,
            viewportFraction: 1,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            /*          autoPlayInterval: Duration(seconds: 2),*/
          ),
          itemBuilder: (context, index, realIndex) {
            final urlImage = urlImages[index];
            return buildSliderImage(urlImage, index);
          },
        ),
      ],
    );
  }

  // Extracted Widget that contains the code for building Slider Image
  Widget buildSliderImage(String urlImage, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.sp),
        color: Colors.white,
        boxShadow: [
          boxShadow,
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.sp),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.92,
          //margin: const EdgeInsets.symmetric(horizontal: 0),
          child: Image.asset(
            urlImage,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  // Extracted Widget that contains the code for My Recent Order
  Widget myAppointment() {
    return GestureDetector(
      onTap: () async {
        await showLoginDialog(context, loginData);
      },
      child: Container(
        height: 55.sp,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            boxShadow,
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 12.sp, left: 18.sp),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/list.png',
                      width: 28.sp,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Appointment',
                          style: kStyleHomeTitle.copyWith(
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                              fontSize: 11.sp),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          'View your appointment details.',
                          style: kStyleHomeTitle.copyWith(
                              fontWeight: FontWeight.w400, fontSize: 10.sp),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  width: 6,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Extracted Widget that contains the code for Referral Offer
  Widget adContents() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.sp),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.sp),
        ),
        //height: 96,
        width: MediaQuery.of(context).size.width,
        //margin: const EdgeInsets.symmetric(horizontal: 0),
        child: AspectRatio(
          aspectRatio: 13 / 4,
          child: Image.asset(
            adImages[0],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
/*
// Extracted Widget that contains the code for ProductsContent
class ProductsContent extends StatelessWidget {
  const ProductsContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.sp),
          color: Colors.white,
          boxShadow: [
            boxShadow,
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.sp),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.sp),
            ),
            width: MediaQuery.of(context).size.width,
            //margin: const EdgeInsets.symmetric(horizontal: 0),
            child: AspectRatio(
              aspectRatio: 8 / 4,
              child: Image.asset(
                'assets/aboutcovid.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}*/
