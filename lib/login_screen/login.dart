import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gaspol/Preferences.dart';
import 'package:gaspol/admin_home_screen.dart';
import 'package:gaspol/employee_home_screen.dart';
import 'package:gaspol/login_screen/login_api.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;
  String errorMessage = "";
  bool _passwordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Employee Assessment',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32.0),
                    Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _usernameController,
                              decoration: const InputDecoration(
                                labelText: 'Username',
                                labelStyle: TextStyle(fontFamily: 'poppins'),
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(fontFamily: 'poppins'),
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: GestureDetector(
                                  onTap: _togglePasswordVisibility,
                                  child: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                                border: const OutlineInputBorder(),
                              ),
                              obscureText: !_passwordVisible,
                            ),
                            const SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: () {
                                final String username =
                                    _usernameController.text;
                                final String password =
                                    _passwordController.text;

                                setState(() {
                                  isLoading = true;
                                });

                                if (username.isEmpty || password.isEmpty) {
                                  errorMessage = "Field not filled";
                                  Fluttertoast.showToast(
                                      msg: "Field not filled",
                                      toastLength: Toast.LENGTH_SHORT);
                                } else {
                                  login(username, password).then((response) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    if (!response.error) {
                                      if (response.user?.type == 1) {
                                        Preferences().saveSession(response.user?.type, response.user?.username, response.user?.dept);
                                        if (context.mounted) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  AdminHomeScreen(
                                                      name:
                                                      response.user?.username ?? ""),
                                            ),
                                          );
                                        }
                                      } else {
                                        Preferences().saveSession(response.user?.type, response.user?.username, response.user?.dept);
                                        if (context.mounted) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  EmployeeHomeScreen(
                                                    name: response.user?.username ?? "",
                                                    dept: response.user?.dept ?? "",
                                                  ),
                                            ),
                                          );
                                        }
                                      }
                                    } else {
                                      setState(() {
                                        errorMessage = response.message;
                                      });
                                      Fluttertoast.showToast(
                                          msg: response.message,
                                          toastLength: Toast.LENGTH_SHORT);
                                    }
                                  });
                                }
                              },
                              child: isLoading
                                  ? const Center(
                                    child: SizedBox(
                                        width: 34,
                                        height: 34,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                  )
                                  : const Text(
                                      'Login',
                                      style: TextStyle(fontFamily: 'poppins'),
                                    ),
                            ),
                            const SizedBox(height: 8.0),
                            const Text(
                              '© Assesment Employee, 2023',
                              style: TextStyle(
                                fontFamily: 'poppins',
                                fontSize: 12.0,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8.0),
                            if (errorMessage.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                color: Colors.red.withOpacity(0.2),
                                child: Text(
                                  errorMessage,
                                  style: const TextStyle(
                                    color: Colors.red,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
