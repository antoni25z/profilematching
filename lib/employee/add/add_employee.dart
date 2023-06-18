import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gaspol/response/GET_dept_response.dart';
import 'package:gaspol/response/GET_employee_response.dart';
import 'package:intl/intl.dart';

import '../../Utility.dart';
import '../../aspect_criteria/MyApi.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final cUsername = TextEditingController();
  final cFirstName = TextEditingController();
  final cLastName = TextEditingController();
  final cEmail = TextEditingController();
  final cPassword = TextEditingController();
  final cBirthPlace = TextEditingController();
  final cBirthDate = TextEditingController();
  final cJoinDate = TextEditingController();
  final cAddress = TextEditingController();
  final cPromoted = TextEditingController();

  bool isVisible = true;

  List<String> spinnerItems = ['Laki Laki', 'Perempuan'];

  String? deptSpin = null;
  int deptV = -0;
  String? jkSpin = null;

  Widget MyTextInput(String labelText, TextInputType type,
      TextEditingController controller, bool readOnly) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: TextField(
        style: TextStyle(
          fontFamily: 'poppins'
        ),
        controller: controller,
        keyboardType: type,
        readOnly: readOnly,
        decoration: InputDecoration(
            border: const OutlineInputBorder(), labelText: labelText),
      ),
    );
  }

  Widget PasswordTextInput() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: TextFormField(
        controller: cPassword,
        obscureText: isVisible,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(isVisible ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
            ),
            border: const OutlineInputBorder(),
            labelText: "Kata sandi"),
      ),
    );
  }


  Future<void> _birthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: const Locale("id"),
        initialDate: DateTime.now(),
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null) {
      setState(() {
        cBirthDate.value = TextEditingValue(text: DateFormat("yyyy-MM-dd", "id").format(picked));
      });
    }
  }

  Future<void> _joinDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: const Locale("id"),
        initialDate: DateTime.now(),
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null) {
      setState(() {
        cJoinDate.value = TextEditingValue(text: DateFormat("yyyy-MM-dd", "id").format(picked));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                child: const Text(
                  "Add Employee",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              MyTextInput(
                "Nama Penguna",
                TextInputType.text,
                cUsername,
                false,
              ),
              MyTextInput(
                "Nama Awal",
                TextInputType.text,
                cFirstName,
                false,
              ),
              MyTextInput(
                "Nama Akhir",
                TextInputType.text,
                cLastName,
                false,
              ),
              MyTextInput(
                "Email",
                TextInputType.emailAddress,
                cEmail,
                false,
              ),
              PasswordTextInput(),
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.only(left: 13, right: 13, top: 8),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: DropdownButton(
                        hint: const Text(
                          "Pilih Jenis Kelamin",
                          style: TextStyle(
                            fontFamily: 'poppins',
                          ),
                        ),
                        value: jkSpin,
                        isExpanded: true,
                        underline: Container(),
                        items: spinnerItems
                            .map<DropdownMenuItem<String>>((String e) {
                          return DropdownMenuItem<String>(
                            value: e,
                            child: Text(
                              e,
                              style: const TextStyle(
                                fontFamily: 'poppins',
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            jkSpin = value;
                          });
                        }),
                  ),
                ),
              ),
              MyTextInput(
                "Tempat Lahir",
                TextInputType.text,
                cBirthPlace,
                false,
              ),
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
                child: TextField(
                  controller: cBirthDate,
                  keyboardType: TextInputType.datetime,
                  readOnly: true,
                  onTap: () async {
                    _birthDate(context);
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Tanggal Lahir"),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
                child: TextField(
                  controller: cJoinDate,
                  keyboardType: TextInputType.datetime,
                  readOnly: true,
                  onTap: () async {
                    _joinDate(context);
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Tanggal Bergabung"),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.only(left: 13, right: 13, top: 8),
                child: Card(
                  child: FutureBuilder(
                      future: getDepts(),
                      builder: (context, snapshot) {
                        print(snapshot.error.toString());
                        if (snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: DropdownButton(
                                hint: const Text(
                                  "Pilih Departemen",
                                  style: TextStyle(
                                    fontFamily: 'poppins',
                                  ),
                                ),
                                value: deptSpin,
                                isExpanded: true,
                                underline: Container(),
                                items: snapshot.data?.dept
                                    .map<DropdownMenuItem<String>>((e) {
                                  return DropdownMenuItem<String>(
                                    value: e.deptName,
                                    child: Text(
                                      e.deptName,
                                      style: const TextStyle(
                                          fontFamily: 'poppins'),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    deptSpin = value;
                                    var id = snapshot.data?.dept
                                        .singleWhere((element) =>
                                            element.deptName == value)
                                        .id;
                                    deptV = id!;
                                  });
                                }),
                          );
                        } else {
                          return const Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        }
                      }),
                ),
              ),
              MyTextInput(
                "Alamat",
                TextInputType.streetAddress,
                cAddress,
                false,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      if (cFirstName.text.isEmpty ||
                          cLastName.text.isEmpty ||
                          cEmail.text.isEmpty ||
                          jkSpin == null ||
                          cBirthDate.text.isEmpty ||
                          cBirthPlace.text.isEmpty ||
                          cJoinDate.text.isEmpty ||
                          cAddress.text.isEmpty ||
                          deptSpin == null ||
                          cUsername.text.isEmpty ||
                          cPassword.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Data Belum Lengkap",
                            toastLength: Toast.LENGTH_SHORT);
                      } else {
                        showLoaderDialog(context);
                        Employee employee = Employee(
                            id: DateTime.now().millisecond,
                            fname: cFirstName.text,
                            lname: cLastName.text,
                            email: cEmail.text,
                            sex: jkSpin?.characters.first ?? "",
                            birthPlace: cBirthPlace.text,
                            birthDate: cBirthDate.text,
                            joinDate: cJoinDate.text,
                            address: cAddress.text,
                            promoted: 0,
                            dept: Dept(id: deptV, deptName: deptSpin ?? ""),
                            username: cUsername.text,
                            password: cPassword.text
                        );

                        addEmployee(employee).then((value) => {
                              if (value.error)
                                {
                                  Navigator.pop(context),
                                  Fluttertoast.showToast(
                                      msg: value.message,
                                      toastLength: Toast.LENGTH_SHORT),
                                }
                              else
                                {
                                  Fluttertoast.showToast(
                                      msg: value.message,
                                      toastLength: Toast.LENGTH_SHORT),
                                  Navigator.pop(context),
                                  Navigator.pop(context, "detect")
                                }
                            });
                      }
                    },
                    child: const Text("Tambah Karyawan")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
