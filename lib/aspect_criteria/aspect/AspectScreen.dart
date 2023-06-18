import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaspol/aspect_criteria/MyApi.dart';
import 'package:gaspol/aspect_criteria/aspect/add/add_aspect_screen.dart';
import 'package:gaspol/aspect_criteria/aspect/edit/edit_aspect_screen.dart';

class AspectScreen extends StatefulWidget {
  const AspectScreen({super.key});

  @override
  State<AspectScreen> createState() => _AspectScreenState();
}

class _AspectScreenState extends State<AspectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Semua Aspek", style: TextStyle(
            fontFamily: 'poppins'
        ),),
        backgroundColor: Color(0xFF6c72e0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  const AddAspectScreen(),
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
                future: getAspects(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data?.aspects.isEmpty == true) {
                      return const Expanded(
                        child: Center(
                          child: Text("Belum Ada Data"),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data?.aspects.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  var result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          EditAspectScreen(
                                            aspect: snapshot.data
                                                ?.aspects[index],),
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
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))
                                          ),
                                          child: Text(
                                            "${snapshot.data?.aspects[index]
                                                .name}",
                                            style: const TextStyle(
                                                fontFamily: 'poppins',
                                                fontWeight: FontWeight.bold
                                            ),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Column(
                                                children: [
                                                  const Text("Bobot Core",
                                                    style: TextStyle(
                                                        fontFamily: 'poppins'
                                                    ),),
                                                  Text("${snapshot.data
                                                      ?.aspects[index]
                                                      .coreWeight}",
                                                    style: const TextStyle(
                                                        fontFamily: 'poppins'
                                                    ),),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  const Text(
                                                    "Bobot Secondary",
                                                    style: TextStyle(
                                                        fontFamily: 'poppins'
                                                    ),),
                                                  Text("${snapshot.data
                                                      ?.aspects[index]
                                                      .secondaryWeight}",
                                                    style: const TextStyle(
                                                        fontFamily: 'poppins'
                                                    ),),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  const Text(
                                                    "Bobot", style: TextStyle(
                                                      fontFamily: 'poppins'
                                                  ),),
                                                  Text("${snapshot.data
                                                      ?.aspects[index]
                                                      .weight}",
                                                    style: const TextStyle(
                                                        fontFamily: 'poppins'
                                                    ),),
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
                }
            ),
          ],
        ),
      ),
    );
  }
}
