import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Month extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MonthPage(title: 'Month'),
    );
  }
}

class MonthPage extends StatefulWidget {
  MonthPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MonthPageState createState() => _MonthPageState();
}

class _MonthPageState extends State<MonthPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () async {
                    print("firebase");
                    // Firebase.initializeApp();
                    await FirebaseFirestore.instance
                        .collection('test_collection')
                        // .document()
                        .doc('test_collection')
                        .set({
                      'name': 'kato',
                      'age': 20,
                      'sex': 'male',
                      'type': ['A', 'B']
                    });
                  },
                  child: Text('save firebase'))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }
}
