import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CheckinTimeItem extends StatelessWidget {
  const CheckinTimeItem(
      {Key? key, required this.title, required this.icon, required this.status})
      : super(key: key);
  final String title;
  final IconData icon;
  final String status;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 1),
            child: Icon(
              icon,
              size: status == 'in' ? 30.sp : 20.sp,
              color: status == 'in'
                  ? Colors.green
                  : status == 'room'
                      ? Colors.red
                      : Colors.yellow,
            ),
          ),
          Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
