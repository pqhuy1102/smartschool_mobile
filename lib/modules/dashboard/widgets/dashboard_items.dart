import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DashBoardItem extends StatelessWidget {
  const DashBoardItem(
      {Key? key,
      required this.title,
      required this.icon,
      required this.color,
      required this.iconBackground})
      : super(key: key);
  final String title;
  final IconData icon;
  final Color color;
  final Color iconBackground;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 5,
              blurRadius: 20,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 6, top: 30),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(65)),
              child: Icon(
                icon,
                color: color,
                size: 30.sp,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ));
  }
}
