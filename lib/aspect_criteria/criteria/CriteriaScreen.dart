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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  AddCriteriaScreen(),
            ),
          );
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
      body: FutureBuilder(
          future: getCriterias(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                EditCriteriaScreen(
                              criteria: snapshot.data?.criterias[index],
                            ),
                          ),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Text(
                                  "${snapshot.data?.criterias[index].name}",
                                  style: const TextStyle(
                                      fontFamily: 'poppins',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        const Text(
                                          "Tipe",
                                          style:
                                              TextStyle(fontFamily: 'poppins'),
                                        ),
                                        Text(
                                          snapshot.data?.criterias[index]
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
                                              TextStyle(fontFamily: 'poppins'),
                                        ),
                                        Text(
                                          "${snapshot.data?.criterias[index].aspectDetail.name}",
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
                                              TextStyle(fontFamily: 'poppins'),
                                        ),
                                        Text(
                                          checkTarget(snapshot
                                              .data?.criterias[index].target),
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
                  });
            } else {
              return const Expanded(
                  child: Center(child: CircularProgressIndicator()));
            }
          }),
    );
  }
}
