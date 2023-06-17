import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gaspol/Utility.dart';
import 'package:gaspol/aspect_criteria/MyApi.dart';

import '../../../response/GET_aspect_response.dart';

class AddAspectScreen extends StatefulWidget {
  const AddAspectScreen({super.key});

  @override
  State<AddAspectScreen> createState() => _AddAspectScreenState();
}

class _AddAspectScreenState extends State<AddAspectScreen> {
  final cName = TextEditingController();
  final cCoreWeight = TextEditingController();
  final cSecondaryWeight = TextEditingController();
  final cWeight = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Penambahan Aspek",
          style: TextStyle(fontFamily: 'poppins'),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MyTextInput(
              "Nama Aspek",
              TextInputType.text,
              cName,
            ),
            MyTextInput(
              "Bobot Core",
              TextInputType.number,
              cCoreWeight,
            ),
            MyTextInput(
              "Bobot Secondary",
              TextInputType.number,
              cSecondaryWeight,
            ),
            MyTextInput(
              "Bobot",
              TextInputType.number,
              cWeight,
            ),
            Container(
              margin: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  var name = cName.text;
                  var coreW = cCoreWeight.text;
                  var secondaryW = cSecondaryWeight.text;
                  var weight = cWeight.text;

                  if (name.isEmpty || coreW.isEmpty || secondaryW.isEmpty || weight.isEmpty) {
                    Fluttertoast.showToast(msg: "Data Belum Lengkap");
                  } else {
                    showLoaderDialog(context);
                    var aspect = Aspect(id: 0, name: name, coreWeight: coreW as int, secondaryWeight: secondaryW as int, weight: weight as int);
                    addAspect(aspect).then((value)  {
                      if (value.error) {
                        Navigator.pop(context);
                        Fluttertoast.showToast(msg: value.message, toastLength: Toast.LENGTH_SHORT);
                      } else {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    });
                  }
                },
                child: const Text(
                  "Tambah",
                  style: TextStyle(fontFamily: 'poppins'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
