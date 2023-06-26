import 'package:flutter/material.dart';
import 'package:gaspol/attendance/attendance_screen.dart';
import 'package:gaspol/employee/add/add_employee.dart';
import 'package:gaspol/employee/assesment/employee_assesment_screen.dart';
import 'package:gaspol/employee/edit/edit_employee.dart';
import 'package:gaspol/response/GET_employee_response.dart';

import '../Utility.dart';
import '../aspect_criteria/MyApi.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  String search = "";

  Widget employeeItem(Employee? employee) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${employee?.fname} ${employee?.lname}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Departemen : ${employee?.dept.deptName}",
                    style: const TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => EmployeeAssesment(
                              name: "${employee?.fname} ${employee?.lname}",
                              employeeId: employee?.id ?? -0)),
                    );
                  },
                  icon: const Icon(
                    Icons.add_chart,
                    color: Colors.green,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    var result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AttendanceScreen(employeeId: employee?.id ?? 0)),
                    );
                    if (result != null) {
                      setState(() {});
                    }
                  },
                  icon: const Icon(
                    Icons.add_card,
                    color: Colors.green,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: const Text(
                              "Apakah anda yakin ingin menghapus karyawan ini?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Tidak"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                showLoaderDialog(context);

                                deleteEmployee(employee?.id).then((value) => {
                                      if (value.error)
                                        {Navigator.pop(context)}
                                      else
                                        {
                                          Navigator.pop(context),
                                          setState(() {})
                                        }
                                    });
                              },
                              child: const Text("Ya"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Employee'),
        backgroundColor: Color(0xFF6c72e0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const AddEmployee()),
          );
          if (result != null) {
            setState(() {});
          }
        },
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8, top: 8, left: 8, right: 8),
            child: TextField(
              decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  hintText: "Pencarian"),
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
            ),
          ),
          FutureBuilder(
            future: getEmployees(search),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data?.employee.isEmpty == true) {
                  return const Expanded(
                    child: Center(
                      child: Text("Belum Ada Data"),
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.employee.length ?? 0,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        EditEmployee(
                                          employee:
                                              snapshot.data?.employee[index],
                                        )),
                              );
                              if (result != null) {
                                setState(() {});
                              }
                            },
                            child: employeeItem(snapshot.data?.employee[index]),
                          );
                        }),
                  );
                }
              } else {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
