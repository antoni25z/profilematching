import 'package:flutter/material.dart';
import 'package:gaspol/response/GET_employee_response.dart';

import '../aspect_criteria/MyApi.dart';

class ManageEmployee extends StatefulWidget {
  const ManageEmployee({super.key});

  @override
  State<ManageEmployee> createState() => _ManageEmployeeState();
}

class _ManageEmployeeState extends State<ManageEmployee> {
  String search = "";

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(margin: const EdgeInsets.only(left: 7),child:const Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

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
                    "Departemen : ${employee?.dept}",
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

                    },
                    icon: const Icon(
                      Icons.add_chart,
                      color: Colors.green,
                    )),
                IconButton(
                  onPressed: () {
                    AlertDialog(
                      content: const Text("Apakah anda yakin ingin menghapus karyawan ini?"),
                      actions: [
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                          showLoaderDialog(context);

                          deleteEmployee(employee?.id).then((value) => {
                            if (value.error) {
                              Navigator.pop(context)
                            } else {
                              Navigator.pop(context),
                              setState(() {})
                            }
                          });

                        }, child: const Text("Ya"),),
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: const Text("Tidak"),),
                      ],
                    );
                  },
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
                )
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
                return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.employee.length ?? 0,
                      itemBuilder: (context, index) {
                        return employeeItem(snapshot.data?.employee[index]);
                      }),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
