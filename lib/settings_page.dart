import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  void _showDeleteAccountDialog(BuildContext context) {
    String adminPassword = '';
    bool showError = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Delete Account'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Are you sure you want to delete your account?'),
                  SizedBox(height: 16.0),
                  Text('Enter Admin Password:'),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        adminPassword = value;
                        showError = false;
                      });
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Admin Password',
                    ),
                  ),
                  if (showError)
                    Text(
                      'Invalid password. Please try again.',
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    // Implement account deletion logic here
                    if (adminPassword == 'admin123') {
                      // Delete account
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        showError = true;
                      });
                    }
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text('Delete Account'),
                onTap: () => _showDeleteAccountDialog(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
