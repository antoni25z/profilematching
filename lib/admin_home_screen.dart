
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gaspol/login_screen/login.dart';
import 'employee/employee.dart';
import 'calendar_page.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'profile/edit_profile.dart';
import 'settings_page.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {

  void _editProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => EditProfile(),
      ),
    );
  }

  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const LoginScreen(),
      ),
    );
  }

  void _goToEmployeePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => EmployeePage(),
      ),
    );
  }

  void _goToCalendarPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => CalendarPage(),
      ),
    );
  }

  void _goToSettingsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => SettingsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // Remove the top bar
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            Card(
              child: Container(
                decoration: const BoxDecoration(
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
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () =>
                          _editProfile(context), // Open edit profile dialog
                      child: const ProfilePicture(
                        name: '',
                        radius: 30,
                        fontsize: 24,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Welcome, !',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            '',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => _logout(context), // Log out user
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.2, // Adjust the aspect ratio here
                children: [
                  Card(
                    child: InkWell(
                      onTap: () => _goToEmployeePage(context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.person,
                            color: Colors.blue,
                            size: 50,
                          ),
                          SizedBox(height: 8.0),
                          Text('Employee'),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        FaIcon(
                          FontAwesomeIcons.chartBar,
                          color: Colors.green,
                          size: 50,
                        ),
                        SizedBox(height: 8.0),
                        Text('Dashboard'),
                      ],
                    ),
                  ),
                  Card(
                    child: InkWell(
                      onTap: () => _goToSettingsPage(context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.settings,
                            color: Colors.orange,
                            size: 50,
                          ),
                          SizedBox(height: 8.0),
                          Text('Settings'),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: InkWell(
                      onTap: () => _goToCalendarPage(context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.calendar_today,
                            color: Colors.red,
                            size: 50,
                          ),
                          SizedBox(height: 8.0),
                          Text('Calendar'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

