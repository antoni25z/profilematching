import 'package:flutter/material.dart';
import 'add/add_employee.dart';

class EmployeeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            columns: [
              DataColumn(label: Text('No')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Position')),
              DataColumn(label: Text('Division')),
              DataColumn(label: Text('View Detail')),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Laurentius')),
                DataCell(Text('Manager')),
                DataCell(Text('Sales')),
                DataCell(IconButton(
                  icon: Icon(Icons.visibility),
                  onPressed: () {
                    // Handle view detail action
                  },
                )),
              ]),
              DataRow(cells: [
                DataCell(Text('2')),
                DataCell(Text('Dea')),
                DataCell(Text('Supervisor')),
                DataCell(Text('Marketing')),
                DataCell(IconButton(
                  icon: Icon(Icons.visibility),
                  onPressed: () {
                    // Handle view detail action
                  },
                )),
              ]),
              // Add more rows as needed
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEmployee()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
