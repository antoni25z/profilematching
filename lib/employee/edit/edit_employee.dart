import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gaspol/response/GET_dept_response.dart';
import 'package:gaspol/response/GET_employee_response.dart';

import '../../aspect_criteria/MyApi.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key, required this.employee});

  final Employee employee;

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

  Dept deptSpin = Dept(id: -0, deptName: "Pilih Departemen");
  String jkSpin = "Laki Laki";

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

  Widget MyTextInput(String labelText, TextInputType type,
      TextEditingController controller, bool readOnly) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: TextField(
        controller: controller,
        keyboardType: type,
        readOnly: readOnly,
        decoration:
            InputDecoration(border: const OutlineInputBorder(), labelText: labelText),
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

  @override
  void initState() {
    cUsername.text = widget.employee.username;
    cFirstName.text = widget.employee.fname;
    cLastName.text = widget.employee.lname;
    cEmail.text = widget.employee.email;
    cPassword.text = widget.employee.password;
    cBirthPlace.text = widget.employee.birthPlace;
    cBirthDate.text = widget.employee.birthDate;
    cJoinDate.text = widget.employee.joinDate;
    cAddress.text = widget.employee.address;
    cPromoted.text = widget.employee.promoted.toString();

    jkSpin = widget.employee.sex == 'L' ? "Laki Laki" : "Perempuan";
    deptSpin = widget.employee.dept;

    super.initState();
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
                  "Detail Employee",
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
                        value: jkSpin,
                        isExpanded: true,
                        items: spinnerItems
                            .map<DropdownMenuItem<String>>((String e) {
                          return DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            jkSpin = value!;
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
              MyTextInput(
                "Tanggal Lahir",
                TextInputType.datetime,
                cBirthDate,
                true,
              ),
              MyTextInput(
                "Tanggal Bergabung",
                TextInputType.datetime,
                cJoinDate,
                true,
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.only(left: 13, right: 13, top: 8),
                child: Card(
                    child: FutureBuilder(
                        future: getDepts(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: DropdownButton(
                                  value: deptSpin,
                                  isExpanded: true,
                                  items: snapshot.data?.dept
                                      .map<DropdownMenuItem<Dept>>((e) {
                                    return DropdownMenuItem<Dept>(
                                      value: e,
                                      child: Text(e.deptName),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      deptSpin = value as Dept;
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
                        })),
              ),
              MyTextInput(
                "Alamat",
                TextInputType.streetAddress,
                cAddress,
                false,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: ()  {
                      showLoaderDialog(context);

                      Employee employee = Employee(
                          id: widget.employee.id,
                          fname: cFirstName.text,
                          lname: cLastName.text,
                          email: cEmail.text,
                          sex: jkSpin.characters.first,
                          birthPlace: cBirthPlace.text,
                          birthDate: cBirthDate.text,
                          joinDate: cJoinDate.text,
                          address: cAddress.text,
                          promoted: cPromoted.text as int, dept: deptSpin, username: cUsername.text, password: cPassword.text
                      );

                      updateEmployee(employee).then((value) => {
                        if (value.error) {
                          Navigator.pop(context),
                          Fluttertoast.showToast(msg: value.message, toastLength: Toast.LENGTH_SHORT),
                        } else {
                          Fluttertoast.showToast(msg: value.message, toastLength: Toast.LENGTH_SHORT),
                          Navigator.pop(context),
                          Navigator.pop(context)
                        }
                      });
                    },
                    child: Text("Update Karyawan")
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
