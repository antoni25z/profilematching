import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gaspol/Utility.dart';

import '../aspect_criteria/MyApi.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key, required this.employeeId});

  final int employeeId;

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {

  final cPermit = TextEditingController();
  final cSick = TextEditingController();
  final cAlpha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Absensi", style: TextStyle(
          fontFamily: 'poppins'
        ),

        ),
        backgroundColor: Color(0xFF6c72e0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextField(
                controller: cPermit,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Izin",
                    hintStyle:
                    TextStyle(fontFamily: 'poppins')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextField(
                controller: cSick,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Sakit",
                    hintStyle:
                    TextStyle(fontFamily: 'poppins')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextField(
                controller: cAlpha,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Alpha",
                    hintStyle:
                    TextStyle(fontFamily: 'poppins')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ElevatedButton(
                  onPressed: () {
                    showLoaderDialog(context);
                    addAttendance(
                        widget.employeeId ,
                        cPermit.text.isEmpty ? "0" : cPermit.text,
                        cSick.text.isEmpty ? "0" : cSick.text,
                        cAlpha.text.isEmpty ? "0" : cAlpha.text,
                        DateTime.now().month,
                        DateTime.now().year).then((value) {
                          if (value.error) {
                            Fluttertoast.showToast(msg: value.message, toastLength: Toast.LENGTH_SHORT);
                            Navigator.pop(context);
                          } else {
                            Navigator.pop(context);
                            Navigator.pop(context, "detect");
                            Fluttertoast.showToast(msg: value.message, toastLength: Toast.LENGTH_SHORT);
                          }
                    });
                  },
                  child: const Text(
                    "Simpan",
                    style: TextStyle(fontFamily: 'poppins'),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
