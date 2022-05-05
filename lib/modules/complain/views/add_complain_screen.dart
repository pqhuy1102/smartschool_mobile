import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddComplainScreen extends StatelessWidget {
  const AddComplainScreen({Key? key}) : super(key: key);

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
        title: Text(
          'Thêm phản ánh',
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
          decoration: const BoxDecoration(color: Colors.white70),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SafeArea(
              child: SingleChildScrollView(
                  child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CS101 - Introduction to Computer Science',
                  style:
                      TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.w800),
                ),
                // Text(
                //   'Introduction to Computer Science',
                //   style:
                //       TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.w800),
                // ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Giảng viên: Dinh Ba Tien',
                  style:
                      TextStyle(fontSize: 14.0.sp, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 2),
                          child: Icon(
                            Icons.date_range,
                            size: 24.0,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        Text(
                          '29/04/2022',
                          style: TextStyle(
                              fontSize: 14.0.sp, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 2),
                          child: Icon(
                            Icons.location_on,
                            size: 24.0,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        Text(
                          'I44',
                          style: TextStyle(
                              fontSize: 14.0.sp, fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 2),
                      child: Icon(
                        Icons.access_time_filled_rounded,
                        size: 24.0,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    Text(
                      '7:30 - 9:30',
                      style: TextStyle(
                          fontSize: 14.0.sp, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Trạng thái: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0.sp,
                              color: Colors.black)),
                      TextSpan(
                          text: 'Vắng',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0.sp,
                              color: Colors.red)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Thay đổi thành: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0.sp,
                        )),
                    SizedBox(
                      width: 30.0.w,
                      child: DropdownButton(
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                'Hợp lệ',
                                style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.green.shade600,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            value: "1",
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                'Đi trễ',
                                style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.orange.shade600,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            value: "2",
                          ),
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                'Vắng',
                                style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.red.shade600,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            value: "3",
                          ),
                        ],
                        value: "1",
                        onChanged: (selectedValue) {},
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Gửi đến: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0.sp,
                        )),
                    SizedBox(
                      width: 50.0.w,
                      child: DropdownButton(
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(
                            child: Center(
                              child: Text(
                                'Đinh Bá Tiến',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            value: "1",
                          ),
                        ],
                        value: "1",
                        onChanged: (selectedValue) {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('Nội dung phản ánh',
                    style: TextStyle(
                        fontSize: 14.0.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLines: null,
                  minLines: 6,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                      hintText: 'Nêu nội dung phản ánh',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.grey, width: 0.0),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'hoàn tất'.toUpperCase(),
                      style: TextStyle(
                          fontSize: 14.0.sp, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      minimumSize: const Size.fromHeight(40),
                      primary: Colors.blue.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0.sp),
                      ),
                    ))
              ],
            ),
          )))),
    ));
  }
}
