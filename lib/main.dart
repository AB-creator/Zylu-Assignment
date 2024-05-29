import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zyluapp/EmployeeData.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Employee Data',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employees Data'),
      ),
      body: Center(
        child: FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/loadjson/details.json'),
          builder: (context, snapshot) {
            // Decode the JSON
            var newData = json.decode(snapshot.data.toString());

            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                String? stringValue = newData[index]["experience"];
                Color rowColor = Colors.white;
                if (stringValue != null) {
                  int intValue = int.parse(stringValue);

                  if (intValue > 5) {
                    rowColor = Colors.green;
                  } else {
                    rowColor = Colors.white;
                  }
                }
                // if (stringValue != null && stringValue.compareTo(5) == "5") {
                //   rowColor = Colors.green;
                // }
                // value > 5 ? Colors.green : Colors.white;

                return Expanded(
                  child: Card(
                    color: rowColor,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 32, bottom: 32, left: 16, right: 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => EmployeeData()));
                                  },
                                  child: Text(
                                    "Employee Name: " +
                                        newData[index]["employee_name"],
                                    //'Note Title',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                                Text(
                                  "Experience: " +
                                      newData[index]["experience"] +
                                      " years",
                                  //'Note Text',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          //SizedBox(width: 20),
                          Container(
                            height: 50,
                            width: 50,
                            // child: Image.asset(newData[index]['img']),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: newData == null ? 0 : newData.length,
            );
          },
        ),
      ),
    );
  }
}
