import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaspol/Utility.dart';
import 'package:gaspol/aspect_criteria/MyApi.dart';
import 'package:gaspol/aspect_criteria/criteria/add_criteria/add_criteria_screen.dart';
import 'package:gaspol/aspect_criteria/criteria/edit/EditCriteriaScreen.dart';

class CriteriaScreen extends StatefulWidget {
  const CriteriaScreen({super.key});

  @override
  State<CriteriaScreen> createState() => _CriteriaScreenState();
}

class _CriteriaScreenState extends State<CriteriaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Semua Aspek",
          style: TextStyle(fontFamily: 'poppins'),
        ),
        backgroundColor: Color(0xFF6c72e0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  AddCriteriaScreen(),
            ),
          );
          if (result != null) {
            setState(() {

            });
          }
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder(
                future: getCriterias(),
                builder: (context, snapshot) {
                  print(snapshot.error.toString());
                  if (snapshot.hasData) {
                    if (snapshot.data?.criterias.isEmpty == true) {
                      return const Expanded(
                        child: Center(
                          child: Text("Belum Ada Data"),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data?.criterias.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  var result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          EditCriteriaScreen(
                                            criteria: snapshot.data
                                                ?.criterias[index],
                                          ),
                                    ),
                                  );
                                  if (result != null) {
                                    setState(() {

                                    });
                                  }
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: const BoxDecoration(
                                              color: Colors.black26,
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: Text(
                                            "${snapshot.data?.criterias[index]
                                                .name}",
                                            style: const TextStyle(
                                                fontFamily: 'poppins',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Column(
                                                children: [
                                                  const Text(
                                                    "Tipe",
                                                    style:
                                                    TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                        fontFamily: 'poppins'),
                                                  ),
                                                  Text(
                                                    snapshot.data
                                                        ?.criterias[index]
                                                        .type ==
                                                        0
                                                        ? "Core"
                                                        : "Secondary",
                                                    style: const TextStyle(
                                                        fontFamily: 'poppins'),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  const Text(
                                                    "Aspek",
                                                    style:
                                                    TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                        fontFamily: 'poppins'),
                                                  ),
                                                  Text(
                                                    "${snapshot.data
                                                        ?.criterias[index]
                                                        .aspectDetail.name}",
                                                    style: const TextStyle(
                                                        fontFamily: 'poppins'),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  const Text(
                                                    "Target",
                                                    style:
                                                    TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                        fontFamily: 'poppins'),
                                                  ),
                                                  Text(
                                                    checkTarget(snapshot
                                                        .data?.criterias[index]
                                                        .target),
                                                    style: const TextStyle(
                                                        fontFamily: 'poppins'),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    }
                  } else {
                    return const Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
