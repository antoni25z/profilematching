import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _isObscureOldPassword = true;
  bool _isObscureNewPassword = true;
  bool _isObscureConfirmPassword = true;

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
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Change Password',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              obscureText: _isObscureOldPassword,
              decoration: InputDecoration(
                labelText: 'Old Password',
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
            SizedBox(height: 8.0),
            TextField(
              obscureText: _isObscureNewPassword,
              decoration: InputDecoration(
                labelText: 'New Password',
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
            SizedBox(height: 8.0),
            TextField(
              obscureText: _isObscureConfirmPassword,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
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
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Implement password changing functionality here
              },
              child: Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}
