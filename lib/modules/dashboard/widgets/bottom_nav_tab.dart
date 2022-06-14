import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BottomNavTab extends StatelessWidget {
  const BottomNavTab(
      {Key? key,
      required this.title,
      required this.icon,
      required this.isSelected,
      required this.onTap})
      : super(key: key);
  final String title;
  final IconData icon;
  final bool isSelected;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 4),
                child: Icon(
                  icon,
                  color:
                      isSelected ? Colors.blue.shade900 : Colors.grey.shade400,
                  size: isSelected ? 20.0.sp : 18.0.sp,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                    color: isSelected
                        ? Colors.blue.shade900
                        : Colors.grey.shade800,
                    fontSize: isSelected ? 15.0.sp : 14.0.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w300,
                    letterSpacing: 0.8),
              ),
            ],
          )),
      onTap: onTap,
    );
  }
}
