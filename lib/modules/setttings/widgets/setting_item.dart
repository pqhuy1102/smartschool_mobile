import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({Key? key, required this.title, required this.icon})
      : super(key: key);
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
          color: Colors.white,
        ),
        child: ListTile(
          leading: Icon(
            icon,
            size: 18.0.sp,
            color: Colors.black,
          ),
          title: Text(
            title,
            style: TextStyle(
                fontSize: textScale > 1.4 ? 14.0.sp / textScale * 1.4 : 14.0.sp,
                fontWeight: FontWeight.w600),
          ),
        ));
  }
}
