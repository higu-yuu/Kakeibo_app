import 'package:flutter/material.dart';

class Month extends StatelessWidget {
  String name;
  Month(this.name);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: name,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MonthEvent(title: name),
    );
  }
}

class MonthEvent extends StatefulWidget {
  MonthEvent({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MonthEventState createState() => _MonthEventState();
}

class _MonthEventState extends State<MonthEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(

      ),
    );
  }
}