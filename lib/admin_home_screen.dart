import 'package:flutter/material.dart';
import 'package:gaspol/aspect_criteria/aspect/AspectScreen.dart';
import 'package:gaspol/aspect_criteria/criteria/CriteriaScreen.dart';
import 'package:gaspol/employee/employee_screen.dart';
import 'package:gaspol/login_screen/login.dart';
import 'package:gaspol/result_rating/ResultRatingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key, required this.name});

  final String name;

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {

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
              child: Padding(
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
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: 1.2, // Adjust the aspect ratio here
                  children: [
                    Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const EmployeeScreen(),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.person,
                              color: Colors.blue,
                              size: 50,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Employee',
                              style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const ResultRatingScreen(),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.add_chart_sharp,
                              color: Colors.green,
                              size: 50,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Penilaian',
                              style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const AspectScreen(),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.accessibility_outlined,
                              color: Colors.orange,
                              size: 50,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Aspek',
                              style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const CriteriaScreen(),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.accessibility_new_sharp,
                              color: Colors.red,
                              size: 50,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Kriteria Aspek',
                              style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
