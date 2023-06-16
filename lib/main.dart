import 'package:flutter/material.dart';
import 'package:gaspol/admin_home_screen.dart';
import 'package:gaspol/employee/add/add_employee.dart';
import 'package:gaspol/employee/assesment/employee_assesment_screen.dart';
import 'package:gaspol/employee/manage_employee.dart';
import 'package:gaspol/employee_home_screen.dart';
import 'package:gaspol/login_screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  int? type = pref.getInt("type");

  runApp(MyApp(
    type: type,
  ));
}

class MyApp extends StatelessWidget {
  final int? type;

  const MyApp({super.key, this.type});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: EmployeeAssesment(),
      /*
      home: type == null
          ? const LoginScreen()
          : type == 1
              ? const EmployeeHomeScreen()
              : const AdminHomeScreen(),

       */
    );
  }
}
