import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddEvent extends StatelessWidget {
  String name;
  AddEvent(this.name);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: name,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddEventPage(title: name),
    );
  }
}

class AddEventPage extends StatefulWidget {
  AddEventPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AddEventState createState() => _AddEventState();

  void setState(DateTime Function() param0) {}
}

class _AddEventState extends State<AddEventPage> {
  DateTime _date = new DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2016),
        lastDate: new DateTime.now().add(new Duration(days: 360)));
    if (picked != null) setState(() => _date = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Row(
          children: [
            Text('タイトル'),
            TextField(),
            Text('金額'),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            Center(child: Text("${_date}")),
            new RaisedButton(
              onPressed: () => _selectDate(context),
              child: new Text('日付選択'),
            ),
            Text('詳細'),
            TextField(),
          ],
        ),
      ),
    );
  }
}
