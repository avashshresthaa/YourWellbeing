import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';

class ContentListTopic extends StatefulWidget {
  ContentListTopic(this.text, this.icon, this.color, this.page);

  final text;
  final IconData icon;
  final color;
  final page;

  @override
  State<ContentListTopic> createState() => _ContentListTopicState();
}

class _ContentListTopicState extends State<ContentListTopic> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return widget.page;
        }));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.blue[100]!.withOpacity(0.5),
                blurRadius: 4.0, // soften the shadow
                offset: Offset(
                  2.0, // Move to right 10  horizontally
                  2.0, // Move to bottom 10 Vertically
                ),
              ),
            ]),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 12),
                  height: 36,
                  width: 4,
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      widget.text!,
                      style: kStyleHomeTitle,
                    )),
                    CircleAvatar(
                        radius: 13,
                        backgroundColor: Colors.blue[50],
                        child: Icon(
                          widget.icon,
                          size: 25,
                          color: Colors.blueAccent[100],
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContentList extends StatelessWidget {
  final text;
  final page;

  ContentList({
    this.text,
    this.page,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return page;
        }));
      },
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 14.0,
        ),
        child: Container(
          height: 55.sp,
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      text,
                      style: kStyleHomeTitle.copyWith(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                          fontSize: 11.sp),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/forwardarrow.png',
                    width: 24,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
