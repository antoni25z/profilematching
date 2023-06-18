import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaspol/profile/edit_profile.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Utility.dart';
import 'aspect_criteria/MyApi.dart';
import 'login_screen/login.dart';

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({super.key, required this.name, required this.dept});

  final String name;
  final String dept;

  @override
  State<EmployeeHomeScreen> createState() => _EmployeeHomeScreeState();
}

class _EmployeeHomeScreeState extends State<EmployeeHomeScreen> {

  Future<void> _logout(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const LoginScreen(),
        ),
      );
    }
  }

  DateTime _selected = DateTime.now();

  Future<void> _onPressed({
    required BuildContext context,
    String? locale,
  }) async {
    final localeObj = locale != null ? Locale(locale) : null;
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: _selected,
      firstDate: DateTime(2023),
      lastDate: DateTime(2050),
      locale: localeObj,
    );
    if (selected != null) {
      setState(() {
        _selected = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF898ee6),
                    Color(0xFF7b80e3),
                    Color(0xFF6c72e0),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Row (
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => EditProfile(name: widget.name, dept: widget.dept,),
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/ic_profile.png"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Welcome, ${widget.name}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      _onPressed(context: context, locale: "id");
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(left: 8, top: 8),
                      width: 170,
                      height: 50,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.blue),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(
                              "${months[_selected.month - 1]} ${_selected.year}",
                              style: const TextStyle(
                                  color: Colors.white, fontFamily: 'poppins'),
                            ),
                          ),
                          const Icon(
                            Icons.calendar_month,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  FutureBuilder(
                      future: getRatingResults(_selected.year, _selected.month),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data?.data.isEmpty == true) {
                            return const Expanded(
                              child: Center(
                                child: Text("Belum Ada Data"),
                              ),
                            );
                          } else {
                            return Expanded(
                              child: ListView.builder(
                                  itemCount: snapshot.data?.data.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.all(8),
                                      child: Card(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 8, top: 8),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 25,
                                                        height: 25,
                                                        alignment: Alignment
                                                            .center,
                                                        margin: const EdgeInsets
                                                            .only(right: 8),
                                                        decoration: BoxDecoration(
                                                            borderRadius: const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    15)),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black,
                                                                width: 1.0)
                                                        ),
                                                        child: Text(
                                                          "${index + 1}",
                                                          style: const TextStyle(
                                                              fontFamily: 'poppins',
                                                              fontWeight: FontWeight
                                                                  .bold
                                                          ),),
                                                      ),
                                                      Text("${snapshot.data
                                                          ?.data[index]
                                                          .employeeDetail
                                                          .employeeName}",
                                                        style: const TextStyle(
                                                            fontFamily: 'poppins',
                                                            fontWeight: FontWeight
                                                                .bold
                                                        ),)
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .all(8.0),
                                                      child: Text(
                                                        "Alpha : ${snapshot.data
                                                            ?.data[index].alpha}",
                                                        style: const TextStyle(
                                                            fontFamily: 'poppins'
                                                        ),),
                                                    ),
                                                    Text("Izin : ${snapshot.data
                                                        ?.data[index].permit}",
                                                      style: const TextStyle(
                                                          fontFamily: 'poppins'
                                                      ),),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .all(8.0),
                                                      child: Text(
                                                        "Sakit : ${snapshot.data
                                                            ?.data[index].sick}",
                                                        style: const TextStyle(
                                                            fontFamily: 'poppins'
                                                        ),),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            Container(
                                              margin: const EdgeInsets.all(8),
                                              child: Text(
                                                "${snapshot.data?.data[index]
                                                    .result}",
                                                style: const TextStyle(
                                                    fontFamily: 'poppins',
                                                    fontWeight: FontWeight.bold
                                                ),),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          }
                        } else {
                          return const Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      }
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _logout(context);
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 50,
                color: const Color(0xFF6c72e0),
                child: const Text("Keluar",  style: TextStyle(
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
