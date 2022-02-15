import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeScreen extends StatelessWidget {
  const QRCodeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Mã QR',
        ),
        actions: [
          // ignore: avoid_returning_null_for_void
          IconButton(onPressed: () => null, icon: const Icon(Icons.info))
        ],
        backgroundColor: Colors.blue.shade900,
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QrImage(
                  data: Random().nextInt(1900).toString(),
                  version: 3,
                  gapless: false,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  child: ElevatedButton(
                    child: const Text(
                      "Làm mới",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade900,
                      // onSurface: Colors.transparent,
                      // shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 110, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          )),
    ));
  }
}
