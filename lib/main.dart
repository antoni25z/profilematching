import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gaspol/admin_home_screen.dart';
import 'package:gaspol/employee_home_screen.dart';
import 'package:gaspol/result_rating/ResultRatingScreen.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  int? type = pref.getInt("type");
  String? dept = pref.getString("dept");
  String? name = pref.getString("name");

  runApp(MyApp(
    type: type,
    dept: dept,
    name: name,
  ));
}

class MyApp extends StatelessWidget {
  final int? type;
  final String? dept;
  final String? name;

  const MyApp({super.key, this.type, this.dept, this.name});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: type == null
          ? const LoginScreen()
          : type == 1
              ? EmployeeHomeScreen(name: name ?? "", dept: dept ?? "",)
              : AdminHomeScreen(name: name ?? "",),
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
    );
  }
}
