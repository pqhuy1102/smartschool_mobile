import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smartschool_mobile/modules/notification/controllers/notifications_controller.dart';
import 'package:smartschool_mobile/modules/notification/widgets/notification_item.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);
  final NotificationsController _notificationsController =
      Get.put(NotificationsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.blue.shade900,
              size: 24.0.sp,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            IconButton(
              onPressed: handleDeleteAllNotif,
              icon: const Icon(
                Icons.delete,
              ),
              iconSize: 30.0.sp,
              color: Colors.red,
            )
          ],
          title: Text(
            'Thông báo',
            style: TextStyle(
                fontSize: 26.0.sp,
                color: Colors.blue.shade900,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            child: SafeArea(
                child: Column(
              children: [
                Expanded(
                    child: ListView(
                  children: [
                    Slidable(
                      child: const NotificationItem(
                        icon: Icons.notifications_active,
                        isSeen: false,
                        title: "Đơn xin nghỉ phép được chấp nhận",
                        content:
                            "Đơn xin nghỉ phép môn CS469 ngày 22/02/2022 của bạn đã được chấp nhận",
                        date: "22/02/2022",
                      ),
                      key: const ValueKey(0),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: handleDeleteNotif,
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red.shade600,
                            icon: Icons.delete,
                            label: "Xóa",
                          ),
                        ],
                      ),
                    ),
                    const NotificationItem(
                      icon: Icons.notifications_active,
                      isSeen: true,
                      title: "Đơn xin nghỉ phép được chấp nhận",
                      content:
                          "Đơn xin nghỉ phép môn CS469 ngày 22/02/2022 của bạn đã được chấp nhận",
                      date: "22/02/2022",
                    ),
                    const NotificationItem(
                      icon: Icons.notifications_active,
                      isSeen: false,
                      title: "Đơn xin nghỉ phép được chấp nhận",
                      content:
                          "Đơn xin nghỉ phép môn CS469 ngày 22/02/2022 của bạn đã được chấp nhận",
                      date: "22/02/2022",
                    ),
                    Center(
                      child: Text(_notificationsController.token.value),
                    )
                  ],
                ))
              ],
            ))),
      ),
    );
  }
}

void doNothing(BuildContext context) {}

void handleDeleteNotif(BuildContext context) {
  Get.defaultDialog(
      title: 'Xóa thông báo?',
      titleStyle: TextStyle(fontSize: 18.0.sp),
      middleText: 'Bạn có muốn xóa thông báo này?',
      middleTextStyle: TextStyle(fontSize: 14.0.sp),
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
                side: BorderSide(color: Colors.blue.shade900)),
          ),
          onPressed: (() {
            Get.back();
          }),
          child: Text(
            'Hủy bỏ',
            style: TextStyle(fontSize: 14.0.sp, color: Colors.blue.shade900),
          )),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18));
}

void handleDeleteAllNotif() {
  Get.defaultDialog(
      title: 'Xóa tất cả thông báo?',
      titleStyle: TextStyle(fontSize: 18.0.sp),
      middleText:
          'Khi bạn xóa tất cả thông báo, bạn không thể phục hồi được thông báo đã xóa',
      middleTextStyle: TextStyle(fontSize: 14.0.sp),
      backgroundColor: Colors.white,
      radius: 10.0,
      confirm: ElevatedButton(
          onPressed: (() {}),
          child: Text(
            'Xóa tất cả',
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
                side: BorderSide(color: Colors.blue.shade900)),
          ),
          onPressed: (() {
            Get.back();
          }),
          child: Text(
            'Hủy bỏ',
            style: TextStyle(fontSize: 14.0.sp, color: Colors.blue.shade900),
          )),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18));
}
