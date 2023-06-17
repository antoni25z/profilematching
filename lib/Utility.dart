import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showLoaderDialog(BuildContext context){
  AlertDialog alert=AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(margin: const EdgeInsets.only(left: 7),child:const Text("Loading..." )),
      ],),
  );
  showDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
}

Widget MyTextInput(
    String labelText, TextInputType type, TextEditingController controller) {
  return Container(
    margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
    child: TextField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          labelStyle: TextStyle(fontFamily: 'poppins')),
    ),
  );
}

double checkTargetValue(String? target) {
  switch(target) {
    case "Sangat Kurang": {
      return 1.0;
    }
    case "Kurang": {
      return 2.0;
    }
    case "Cukup": {
      return 3.0;
    }
    case "Baik": {
      return 4.0;
    }
    case "Sangat Baik": {
      return 5.0;
    }
    default: return 0;
  }
}

String checkTarget(int? target) {
  switch(target) {
    case 1: {
      return "Sangat Kurang";
    }
    case 2: {
      return "Kurang";
    }
    case 3: {
      return "Cukup";
    }
    case 4: {
      return "Baik";
    }
    case 5: {
      return "Sangat Baik";
    }
    default: return "";
  }
}

List<String> listBobotPenilaian = [
  "Sangat Baik",
  "Baik",
  "Cukup",
  "Kurang",
  "Sangat Kurang"
];

List<String> types = [
  "Core",
  "Secondary",
];