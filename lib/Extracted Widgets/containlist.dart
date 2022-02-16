import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yourwellbeing/Constraints/constraints.dart';

Widget itemDivider() {
  return const SizedBox(
    width: double.infinity,
    height: 0,
    child: Divider(
      color: Color(0xffD8DDE0),
      thickness: 1,
    ),
  );
}

class ContentItems extends StatelessWidget {
  ContentItems(
      {Key? key,
      required this.image,
      required this.label,
      required this.containerDesignType,
      required this.onTap})
      : super(key: key);

  final image;
  final label;
  final containerDesignType;
  final onTap;

  final kRadius = Radius.circular(8.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            containerDesignType == "bottom" ? boxShadow : const BoxShadow(),
          ],
          borderRadius: containerDesignType == "top"
              ? BorderRadius.only(topLeft: kRadius, topRight: kRadius)
              : containerDesignType == "bottom"
                  ? BorderRadius.only(bottomLeft: kRadius, bottomRight: kRadius)
                  : containerDesignType == "both"
                      ? const BorderRadius.all(Radius.circular(0.0))
                      : const BorderRadius.all(Radius.circular(0.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(height: 22, width: 22, child: Image.asset(image)),
                  const SizedBox(
                    width: 18,
                  ),
                  Text(
                    label,
                    style: kStyleButtonContent.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                  height: 22,
                  width: 22,
                  child: Image.asset('assets/forwardarrow.png'))
            ],
          ),
        ),
      ),
    );
  }
}
