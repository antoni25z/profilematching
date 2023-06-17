import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gaspol/response/GET_criteria_response.dart';

import '../../../Utility.dart';
import '../../MyApi.dart';

class EditCriteriaScreen extends StatefulWidget {
  const EditCriteriaScreen({super.key, required this.criteria});

  final Criteria? criteria;

  @override
  State<EditCriteriaScreen> createState() => _EditCriteriaScreenState();
}

class _EditCriteriaScreenState extends State<EditCriteriaScreen> {

  final cName = TextEditingController();

  int aspectV = -0;
  int targetV = -0;
  int typeV = -0;

  String? aspectSpin = null;
  String? targetSpin = null;
  String? typeSpin = null;

  @override
  void initState() {
    cName.text = widget.criteria?.name ?? "";
    aspectSpin = widget.criteria?.aspectDetail.name;
    aspectV =widget.criteria?.aspectDetail.id ?? -0;

    targetV = widget.criteria?.target ?? -0;
    targetSpin = checkTarget(widget.criteria?.target);

    typeV = widget.criteria?.type ?? -0;
    typeSpin = widget.criteria?.type == 0 ? "Core" : "Secondary";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Penambahan Kriteria Aspek",
          style: TextStyle(fontFamily: 'poppins'),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MyTextInput(
              "Nama Kriteria",
              TextInputType.text,
              cName,
            ),
            FutureBuilder(
                future: getAspects(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      width: double.infinity,
                      height: 50,
                      margin: const EdgeInsets.only(left: 13, right: 13, top: 8),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: DropdownButton(
                              hint: Text("Pilih Aspek"),
                              value: aspectSpin,
                              underline: Container(),
                              isExpanded: true,
                              items: snapshot.data?.aspects
                                  .map((e) {
                                return DropdownMenuItem(
                                  value: e.name,
                                  child: Text(e.name),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  aspectSpin = value;
                                  var id = snapshot.data?.aspects
                                      .singleWhere((element) =>
                                  element.name == value)
                                      .id;
                                  aspectV = id!;
                                });
                              }),
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  }
                }
            ),
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.only(left: 13, right: 13, top: 8),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: DropdownButton(
                      hint: Text("Pilih Tipe"),
                      underline: Container(),
                      value: typeSpin,
                      isExpanded: true,
                      items: types
                          .map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          typeSpin = value;
                          typeV = value == "Core" ? 0 : 1;
                        });
                      }),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.only(left: 13, right: 13, top: 8),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: DropdownButton(
                      hint: Text("Pilih Target"),
                      underline: Container(),
                      value: targetSpin,
                      isExpanded: true,
                      items: listBobotPenilaian
                          .map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          targetSpin = value;
                          targetV = checkTargetValue(value).toInt();
                        });
                      }),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  var name = cName.text;

                  if (name.isEmpty || aspectSpin == null || typeSpin == null || targetSpin == null) {
                    Fluttertoast.showToast(msg: "Data Belum Lengkap");
                  } else {
                    showLoaderDialog(context);
                    var criteria = Criteria(id: 0, name: name, type: typeV, target: targetV, deptId: 0, aspectDetail: AspectDetail(id: aspectV, name: aspectSpin ?? ""));
                    editCriteria(criteria).then((value)  {
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
                  "Simpan",
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
