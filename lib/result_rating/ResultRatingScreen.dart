import 'package:flutter/material.dart';
import 'package:gaspol/Utility.dart';
import 'package:gaspol/aspect_criteria/MyApi.dart';
import 'package:month_year_picker/month_year_picker.dart';

class ResultRatingScreen extends StatefulWidget {
  const ResultRatingScreen({super.key});

  @override
  State<ResultRatingScreen> createState() => _ResultRatingScreenState();
}

class _ResultRatingScreenState extends State<ResultRatingScreen> {
  DateTime _selected = DateTime.now();

  Future<void> _onPressed({
    required BuildContext context,
    String? locale,
  }) async {
    final localeObj = locale != null ? Locale(locale) : null;
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: _selected,
      firstDate: DateTime(2023),
      lastDate: DateTime(2050),
      locale: localeObj,
    );
    if (selected != null) {
      setState(() {
        _selected = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Peringkat Rating",
          style: TextStyle(fontFamily: 'poppins'),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                _onPressed(context: context, locale: "id");
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(left: 8, top: 8),
                width: 170,
                height: 50,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.blue),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        "${months[_selected.month - 1]} ${_selected.year}",
                        style: const TextStyle(
                            color: Colors.white, fontFamily: 'poppins'),
                      ),
                    ),
                    const Icon(
                      Icons.calendar_month,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            FutureBuilder(
              future: getRatingResults(_selected.year, _selected.month),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 8, top: 8),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 25,
                                            height: 25,
                                            alignment: Alignment.center,
                                            margin: const EdgeInsets.only(right: 8),
                                            decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(
                                                    Radius.circular(15)),
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0)
                                            ),
                                            child: Text("${index + 1}", style: const TextStyle(
                                                fontFamily: 'poppins',
                                                fontWeight: FontWeight.bold
                                            ),),
                                          ),
                                          Text("${snapshot.data?.data[index].employeeDetail.employeeName}", style: const TextStyle(
                                              fontFamily: 'poppins',
                                              fontWeight: FontWeight.bold
                                          ),)
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Alpha : ${snapshot.data?.data[index].alpha}", style: const TextStyle(
                                              fontFamily: 'poppins'
                                          ),),
                                        ),
                                        Text("Izin : ${snapshot.data?.data[index].permit}", style: const TextStyle(
                                            fontFamily: 'poppins'
                                        ),),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Sakit : ${snapshot.data?.data[index].sick}", style: const TextStyle(
                                              fontFamily: 'poppins'
                                          ),),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.all(8),
                                  child: Text("${snapshot.data?.data[index].result}", style: const TextStyle(
                                      fontFamily: 'poppins',
                                      fontWeight: FontWeight.bold
                                  ),),
                                )
                              ],
                            ),
                          );
                        }),
                  );
                } else {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }
            ),
          ],
        ),
      ),
    );
  }
}
