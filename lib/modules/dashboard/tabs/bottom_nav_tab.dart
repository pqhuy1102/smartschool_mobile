import 'package:flutter/material.dart';

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
                  color: isSelected
                      ? Colors.indigo.shade800
                      : Colors.grey.shade400,
                  size: isSelected ? 28 : 25,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                    color: isSelected
                        ? Colors.indigo.shade800
                        : Colors.grey.shade800,
                    fontSize: isSelected ? 20 : 18,
                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.w300,
                    letterSpacing: 1),
              ),
            ],
          )),
      onTap: onTap,
    );
  }
}