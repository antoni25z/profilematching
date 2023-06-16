import 'package:flutter/material.dart';
import 'package:gaspol/profile/change_password.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(250),
        child: AppBar(
          backgroundColor: Color(0xFF666BDB), // Set the desired color
          elevation: 0,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
              SizedBox(height: 16.0),
              Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.0),
              Text(
                'Division: Software Engineer',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 24.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Color(0xFF666BDB),
                ),
                title: Text('Update Profile'),
                trailing: Icon(Icons.arrow_right_sharp),
                onTap: () {
                  // Implement profile updating functionality here
                },
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              child: ListTile(
                leading: Icon(
                  Icons.lock,
                  color: Color(0xFF666BDB),
                ),
                title: Text('Change Password'),
                trailing: Icon(Icons.arrow_right_sharp),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePassword(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
