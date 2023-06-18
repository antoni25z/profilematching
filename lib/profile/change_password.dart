import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gaspol/Utility.dart';
import 'package:gaspol/aspect_criteria/MyApi.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key, required this.username});

  final String username;



  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _isObscureOldPassword = true;
  bool _isObscureNewPassword = true;
  bool _isObscureConfirmPassword = true;

  final cOld = TextEditingController();
  final cNew = TextEditingController();
  final cConfirm = TextEditingController();

  void _toggleObscureOldPassword() {
    setState(() {
      _isObscureOldPassword = !_isObscureOldPassword;
    });
  }

  void _toggleObscureNewPassword() {
    setState(() {
      _isObscureNewPassword = !_isObscureNewPassword;
    });
  }

  void _toggleObscureConfirmPassword() {
    setState(() {
      _isObscureConfirmPassword = !_isObscureConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password', style: TextStyle(
          fontFamily: 'poppins',
        ),),
        backgroundColor: const Color(0xFF666BDB),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Change Password',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: cOld,
                obscureText: _isObscureOldPassword,
                decoration: InputDecoration(
                  labelText: 'Old Password',
                  labelStyle: const TextStyle(
                    fontFamily: 'poppins',
                  ),
                  suffixIcon: IconButton(
                    onPressed: _toggleObscureOldPassword,
                    icon: Icon(
                      _isObscureOldPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: cNew,
                obscureText: _isObscureNewPassword,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  labelStyle: const TextStyle(
                    fontFamily: 'poppins',
                  ),
                  suffixIcon: IconButton(
                    onPressed: _toggleObscureNewPassword,
                    icon: Icon(
                      _isObscureNewPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: cConfirm,
                obscureText: _isObscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  labelStyle: const TextStyle(
                    fontFamily: 'poppins',
                  ),
                  suffixIcon: IconButton(
                    onPressed: _toggleObscureConfirmPassword,
                    icon: Icon(
                      _isObscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xFF666BDB))
                ),
                onPressed: () {
                  if (cOld.text.isEmpty || cNew.text.isEmpty || cConfirm.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Data Belum lengkap", toastLength: Toast.LENGTH_SHORT);
                  } else if (cNew.text != cConfirm.text) {
                    Fluttertoast.showToast(msg: "Kata sandi tidak sama", toastLength: Toast.LENGTH_SHORT);
                  } else {
                    showLoaderDialog(context);
                    resetPassword(widget.username, cOld.text, cNew.text).then((value) => {
                      if (value.error) {
                        Fluttertoast.showToast(msg: value.message, toastLength: Toast.LENGTH_SHORT),
                        Navigator.pop(context),
                      } else {
                        Navigator.pop(context),
                        Navigator.pop(context),
                        Fluttertoast.showToast(msg: value.message, toastLength: Toast.LENGTH_SHORT),
                      }
                    });
                  }
                },
                child: const Text('Change Password', style: TextStyle(
                  fontFamily: 'poppins',
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
