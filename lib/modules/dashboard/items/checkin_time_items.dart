import 'package:flutter/material.dart';

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
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 2),
            child: Icon(
              icon,
              size: status == 'in' ? 40 : 30,
              color: status == 'in' ? Colors.green : Colors.red,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
