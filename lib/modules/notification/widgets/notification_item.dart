import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

enum Menu { itemOne, itemTwo, itemThree, itemFour }

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    Key? key,
    required this.icon,
    required this.isSeen,
    required this.title,
    required this.content,
    required this.date,
  }) : super(key: key);

  final IconData icon;
  final bool isSeen;
  final String title;
  final String content;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSeen ? Colors.white : const Color.fromARGB(255, 224, 240, 255),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 14, top: 35, right: 14),
            child: Icon(
              icon,
              color: Colors.blue.shade900,
              size: 30.sp,
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                // ignore: unnecessary_string_interpolations
                "$title",
                style:
                    TextStyle(fontSize: 14.0.sp, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 4,
              ),
              Flexible(
                  child: Wrap(
                children: [
                  Text(
                    // ignore: unnecessary_string_interpolations
                    "$content",
                    style: TextStyle(
                        fontSize: 12.0.sp, fontWeight: FontWeight.w500),
                  ),
                ],
              )),
              const SizedBox(
                height: 6,
              ),
              // ignore: unnecessary_string_interpolations
              Text("$date",
                  style: TextStyle(
                      fontSize: 12.0.sp,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500))
            ],
          )),
          InkWell(
            onTap: _onChoiceSelected,
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              width: 20,
              child: Image.asset(
                'assets/images/three_dots.png',
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
    );
  }

  void handleDeleteNotif() {
    Get.defaultDialog(
        title: 'Xóa thông báo?',
        titleStyle: TextStyle(fontSize: 18.0.sp),
        middleText: 'Bạn có muốn xóa thông báo này?',
        middleTextStyle:
            TextStyle(fontSize: 14.0.sp, fontWeight: FontWeight.w600),
        backgroundColor: Colors.white,
        radius: 10.0,
        confirm: ElevatedButton(
            onPressed: (() {}),
            child: Text(
              'Đồng ý',
              style: TextStyle(fontSize: 14.0.sp, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.red.shade600,
              padding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0.sp),
              ),
            )),
        cancel: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0.sp),
                  side: BorderSide(color: Colors.blue.shade900, width: 1.5)),
            ),
            onPressed: (() {
              Get.back();
            }),
            child: Text(
              'Hủy bỏ',
              style: TextStyle(fontSize: 14.0.sp, color: Colors.blue.shade900),
            )),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 18));
  }

  void _onChoiceSelected() {
    Get.bottomSheet(
      Container(
          height: 205.0,
          color: Colors.white,
          child: ListView(
            children: [
              Container(
                  padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                  decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Colors.grey.shade400)),
                    color: Colors.white,
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.done,
                      size: 18.0.sp,
                      color: Colors.black,
                    ),
                    title: Text(
                      isSeen
                          ? 'Đánh dấu chưa đọc'
                          : 'Đánh dấu là đã đọc',
                      style: TextStyle(
                          fontSize: 14.0.sp, fontWeight: FontWeight.w600),
                    ),
                  )),
              InkWell(
                onTap: handleDeleteNotif,
                child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade400)),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.delete,
                        size: 18.0.sp,
                        color: Colors.black,
                      ),
                      title: Text(
                        'Xóa thông báo này',
                        style: TextStyle(
                            fontSize: 14.0.sp, fontWeight: FontWeight.w600),
                      ),
                    )),
              ),
              InkWell(
                onTap: () => Get.back(),
                child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade400)),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.close,
                        size: 18.0.sp,
                        color: Colors.black,
                      ),
                      title: Text(
                        'Hủy',
                        style: TextStyle(
                            fontSize: 14.0.sp, fontWeight: FontWeight.w600),
                      ),
                    )),
              )
            ],
          )),
    );
  }
}
