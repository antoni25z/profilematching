import 'package:flutter/material.dart';
import 'employee_list.dart';
import 'manage_employee.dart';
import 'history.dart';

class EmployeePage extends StatelessWidget {
  void _goToManageEmployee(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ManageEmployee(),
      ),
    );
  }

  void _goToEmployeeHistory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => History(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: Icon(Icons.people),
                title: Text('Employee List'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => EmployeeList(),
                    ),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.manage_accounts),
                title: Text('Manage Employee'),
                onTap: () => _goToManageEmployee(context),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.history),
                title: Text('Employee History'),
                onTap: () => _goToEmployeeHistory(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
