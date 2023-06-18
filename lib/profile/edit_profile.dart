import 'package:flutter/material.dart';
import 'package:gaspol/profile/change_password.dart';


class EditProfile extends StatefulWidget {
  const EditProfile ({super.key, required this.name, required this.dept});

  final String name;
  final String dept;

  @override
  State<EditProfile> createState() => _StateEditProfile();
}

class _StateEditProfile extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(250),
        child: AppBar(
          backgroundColor: const Color(0xFF666BDB), // Set the desired color
          elevation: 0,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/ic_profile.png'),
              ),
              const SizedBox(height: 16.0),
              Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              Text(
                'Division: ${widget.dept}',
                style: const TextStyle(
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
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              child: ListTile(
                leading: const Icon(
                  Icons.lock,
                  color: Color(0xFF666BDB),
                ),
                title: const Text('Change Password'),
                trailing: const Icon(Icons.arrow_right_sharp),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePassword(username: widget.name,),
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


