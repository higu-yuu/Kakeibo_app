import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'month_event.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'マネマネ&イベント',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'マネマネ&イベント'),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final items = List<String>.generate(12, (i) => "2022年 ${i + 1}月");
  int havingMoney = 0;

  Future<void> getSaving() async {
    var saving_json = await FirebaseFirestore.instance
        .collection('Savings')
        .doc('Savings')
        .get();
    print(saving_json['savings']);
    setState(() {
      havingMoney = saving_json['savings'];
    });
  }

  @override
  void initState() {
    super.initState();
    getSaving();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    var maxHeight = size.height - padding.top - padding.bottom;

    // アプリ描画エリアの縦サイズを取得
    if (Platform.isAndroid) {
      maxHeight = size.height - padding.top - kToolbarHeight;
    } else if (Platform.isIOS) {
      maxHeight = size.height - padding.top - padding.bottom - 22;
    }

    // Resultエリアの縦サイズ
    final resultAreaHeight = maxHeight * (10 / 100);
    // テンキーエリアの縦サイズ
    final tenkeyAreaHeight = maxHeight * (90 / 100);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: size.width,
              height: resultAreaHeight,
              child: Text(
                "所持金 : $havingMoney円",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w800,
                  fontSize: 40,
                ),
              ),
              alignment: Alignment.center,
            ),
            Container(
              width: size.width,
              height: tenkeyAreaHeight,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: new BoxDecoration(
                      border: new Border(
                        top: new BorderSide(color: Colors.black, width: 1.0),
                        bottom: new BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                    child: ListTile(
                      title: Text('${items[index]}'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context, MaterialPageRoute(builder: (context) => Month('${items[index]}')),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
