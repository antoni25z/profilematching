import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gaspol/response/GET_aspect_criteria_response.dart';
import 'package:gaspol/aspect_criteria/MyApi.dart';
import 'package:gaspol/floor/Assessment.dart';
import 'package:gaspol/profile_matching_result.dart';

import '../../Utility.dart';
import '../../floor/AppDatabase.dart';

class EmployeeAssesment extends StatefulWidget {
  const EmployeeAssesment({super.key, required this.name, required this.employeeId});

  final String name;
  final int employeeId;

  @override
  State<EmployeeAssesment> createState() => _EmployeeAssesmentState();
}

class _EmployeeAssesmentState extends State<EmployeeAssesment> {

  List<int> types = [0, 1];
  List<Assessment> an = [];
  List<double> core = [];
  List<double> secondary = [];
  List<ProfileMatchingResult> profiles = [];
  double cresult = 0.0;

  String bobotPenilaian = "Sangat Kurang";

  Map<String, String> test = {};

  double GAPCheck(int target) {
    switch(target) {
      case 0: {
        return 5.0;
      }
      case 1: {
        return 4.5;
      }
      case -1: {
        return 4.0;
      }
      case 2: {
        return 3.5;
      }
      case -2: {
        return 3.0;
      }
      case 3: {
        return 2.5;
      }
      case -3: {
        return 2.0;
      }
      case 4: {
        return 1.5;
      }
      case -4: {
        return 1.0;
      }
      default: return 0;
    }
  }

  Future<List<Assessment>> getAllAssessments() async {
    final database =
    await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    return await database.assessmentDao.getAllAssessments();
  }

  List<Result> aspect = [];

  @override
  void initState() {
    getAspectCriteria().then((value) => {
      aspect.addAll(value.results)
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16, top: 16),
              child: Text(
                "Penilaian Karyawan : ${widget.name}",
                style: const TextStyle(fontFamily: "poppins", fontSize: 18),
              ),
            ),
            FutureBuilder(
              future: getAspectCriteria(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  AspectCriteriaResponse? response = snapshot.data;
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 8, bottom: 8),
                      child: ListView.builder(
                          itemCount: 4,
                          itemBuilder: (context, indexs) {
                            return Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 16, top: 8),
                                    child: Text(
                                      response?.results[indexs].name ?? "",
                                      style: const TextStyle(
                                          fontFamily: 'poppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  ListView.builder(
                                      itemCount: 5,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: SizedBox(
                                            height: 40,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  response?.results[indexs].criteria[index].name ?? "",
                                                  style: const TextStyle(
                                                      fontFamily: 'poppins',
                                                      fontWeight: FontWeight
                                                          .w500
                                                  ),
                                                ),
                                                DropdownButton(
                                                    underline: Container(),
                                                    hint: const Text(
                                                      "Belum Nilai",
                                                      style: TextStyle(
                                                        fontFamily: 'poppins',
                                                      ),
                                                    ),
                                                    value: test["$indexs$index"],
                                                    items: listBobotPenilaian
                                                        .map((e) {
                                                      return DropdownMenuItem(
                                                        value: e,
                                                        child: Text(
                                                          e,
                                                          style: const TextStyle(
                                                            fontFamily: 'poppins',
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) async {
                                                      setState(() {
                                                        test["$indexs$index"] =
                                                        value!;
                                                      });

                                                      var aspect = response?.results[indexs].name ?? "";
                                                      var criteria = response?.results[indexs].criteria[index].name ?? "";
                                                      var type = response?.results[indexs].criteria[index].type ?? -0;
                                                      var bobot = response?.results[indexs].weight ?? -0;
                                                      var bobotPenilaian = GAPCheck((checkTargetValue(test["$indexs$index"]).toInt() - (response?.results[indexs].criteria[index].target ?? 0)));
                                                      var target = response?.results[indexs].criteria[index].target ?? 0;

                                                      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

                                                      await database.assessmentDao
                                                          .addAssessment(Assessment(id: "$indexs$index", aspect: aspect, criteria: criteria, type: type, bobot: bobot, bobot_penilaian: bobotPenilaian, target: target));
                                                    }),
                                                Container(
                                                  padding: const EdgeInsets.all(4),
                                                  decoration: const BoxDecoration(
                                                      color: Colors.black26,
                                                      borderRadius: BorderRadius
                                                          .all(
                                                          Radius.circular(5))
                                                  ),
                                                  child: Text(
                                                   checkTarget(response?.results[indexs].criteria[index].target),
                                                    style: const TextStyle(
                                                        fontFamily: 'poppins',
                                                        color: Colors.black38
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      })
                                ],
                              ),
                            );
                          }),
                    ),
                  );
                } else {
                  return const Expanded(child: Center(child: CircularProgressIndicator(),));
                }
              }
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {

                  showLoaderDialog(context);

                  getAllAssessments().then((value) {
                    for (Result i in aspect) {
                      for (Assessment mode in value) {
                        if (i.name == mode.aspect) {
                          an.add(mode);
                        }
                      }

                      for (Assessment nn in an) {
                        if (nn.type == 0) {
                          core.add(nn.bobot_penilaian);
                        } else {
                          secondary.add(nn.bobot_penilaian);
                        }
                      }
                      double cores = core.fold(0.0, (previous, current) => previous + current) / core.length.toDouble();
                      double second = secondary.fold(0.0, (previous, current) => previous + current) / secondary.length.toDouble();

                      double n = (cores * i.coreWeight) + (second * i.secondaryWeight);

                      profiles.add(ProfileMatchingResult(i.name, n, i.weight));
                      core.clear();
                      secondary.clear();
                      an.clear();
                    }

                    for (ProfileMatchingResult result in profiles) {
                      cresult += result.nilai * (result.bobot / 100);
                    }

                    addResultRating(widget.employeeId, DateTime.now().month, DateTime.now().year, cresult).then((value) {
                      if (value.error) {
                        Navigator.pop(context);
                        Fluttertoast.showToast(msg: value.message, toastLength: Toast.LENGTH_SHORT);
                      } else {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    });
                  });
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
