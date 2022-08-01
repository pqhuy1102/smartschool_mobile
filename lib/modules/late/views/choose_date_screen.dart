import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:smartschool_mobile/modules/late/controllers/late_controller.dart';
import 'package:smartschool_mobile/modules/late/widgets/schedule_inday_item.dart';
import 'package:smartschool_mobile/routes/routes.dart';

class ChooseDateForLateScreen extends StatefulWidget {
  const ChooseDateForLateScreen({Key? key}) : super(key: key);

  @override
  State<ChooseDateForLateScreen> createState() =>
      _ChooseDateForLateScreenState();
}

class _ChooseDateForLateScreenState extends State<ChooseDateForLateScreen> {
  final f = DateFormat('dd/MM/yyyy HH:mm');

  final LateController _lateController = Get.put(LateController());

  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    _lateController.indayAttendanceList.value = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.blue.shade900,
              size: 18.0.sp,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            'Chọn ngày & ca học',
            style: TextStyle(
                fontSize: textScale > 1.4 ? 17.0.sp / textScale * 1.4 : 17.0.sp,
                color: Colors.blue.shade900,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Text('Chọn ngày xin nghỉ phép/ đi trễ',
                    style: TextStyle(
                      fontSize:
                          textScale > 1.4 ? 13.0.sp / textScale * 1.3 : 13.0.sp,
                      color: Colors.black,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: SizedBox(
                    width: 260.0,
                    child: TextFormField(
                      style: TextStyle(
                          height: 1.0,
                          fontSize: textScale > 1.4
                              ? 13.0.sp / textScale * 1.3
                              : 13.0.sp,
                          fontWeight: FontWeight.w500),
                      controller: dateInput,
                      //editing controller of this TextField
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.date_range,
                          size: 20.0.sp,
                          color: Colors.blue.shade900,
                        ),
                        labelText: "Chọn ngày",
                        labelStyle: TextStyle(
                            color: Colors.blue.shade900, fontSize: 12.0.sp),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blue.shade900, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blue.shade900, width: 1.5),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.blue.shade900, width: 1.5)),
                        //label text of field
                      ),
                      readOnly: true,
                      //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                          String formattedDateRequest =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          _lateController
                              .getIndayAttendance(formattedDateRequest);
                          //formatted date output using intl package =>  2021-03-16
                          setState(() {
                            dateInput.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {}
                      },
                    ),
                  )),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(22, 0, 22, 0),
                child: Row(
                  children: List.generate(
                      1000 ~/ 10,
                      (index) => Expanded(
                            child: Container(
                              color: index % 2 == 0
                                  ? Colors.transparent
                                  : Colors.grey,
                              height: 2,
                            ),
                          )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "Các ca học trong ngày",
                  style: TextStyle(
                      fontSize:
                          textScale > 1.4 ? 14.0.sp / textScale * 1.3 : 14.0.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(() {
                if (_lateController.isRequestLoading.isTrue) {
                  return Center(
                    child: SpinKitFadingFour(
                      color: Colors.blue.shade900,
                      size: 35.0.sp,
                    ),
                  );
                } else if (_lateController.indayAttendanceList.isEmpty) {
                  return Column(
                    children: [
                      Image.asset(
                        'assets/images/no_data.gif',
                      ),
                      Center(
                          child: Text(
                        'Danh sách trống! ',
                        style: TextStyle(
                            fontSize: textScale > 1.4
                                ? 13.0.sp / textScale * 1.3
                                : 13.0.sp,
                            fontWeight: FontWeight.w600),
                      ))
                    ],
                  );
                } else {
                  return Expanded(
                      child: ListView.builder(
                          itemCount: _lateController.indayAttendanceList.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            return InkWell(
                              onTap: () {
                                _lateController.getLateForm(_lateController
                                    .indayAttendanceList[index]['schedule_id']);
                                Get.toNamed(Routes.lateApplicationFormList +
                                    Routes.chooseDateForLate +
                                    Routes.addLate);
                              },
                              child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(22, 15, 22, 0),
                                  child: ScheduleIndayItem(
                                    startTime: formatDate(_lateController
                                                .indayAttendanceList[index]
                                            ['start_time'])
                                        .substring(10),
                                    endTime: formatDate(_lateController
                                                .indayAttendanceList[index]
                                            ['end_time'])
                                        .substring(10),
                                    course: _lateController
                                        .indayAttendanceList[index]['course'],
                                    room: _lateController
                                        .indayAttendanceList[index]['room'],
                                  )),
                            );
                          })));
                }
              })
            ],
          ),
        ));
  }

  String formatDate(String date) {
    DateTime parseDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(date, true).toLocal();
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd/MM/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
}
