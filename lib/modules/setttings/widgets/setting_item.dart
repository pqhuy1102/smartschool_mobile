import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({Key? key, required this.title, required this.icon})
      : super(key: key);
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
          color: Colors.white,
        ),
        child: ListTile(
          leading: Icon(
            icon,
            size: 18.0.sp,
          ),
          title: Text(
            title,
            style: TextStyle(fontSize: 14.0.sp),
          ),
        ));
  }
}
