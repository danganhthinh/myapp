import 'package:flutter/material.dart';
import 'transaction.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _contentController = TextEditingController();
  final _amountController = TextEditingController();

  //define state
  Transaction _transaction = Transaction(content: '', amount: 0.0);
  List<Transaction> _transactions = <Transaction>[];

  @override
  void intiState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    //now how to display a DataTime?
    DateTime now = new DateTime.now();
    DateTime someDate = new DateTime(2022, 5, 2);
    return MaterialApp(
      title: "This is a StatefulWidget",
      home: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          minimum: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Content'),
                controller: _contentController,
                onChanged: (text) {
                  setState(() {
                    // _content = text;
                    _transaction.content = text;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount(money)'),
                controller: _amountController,
                onChanged: (text) {
                  setState(() {
                    // _amount = double.tryParse(text) ?? 0;
                    _transaction.amount = double.tryParse(text) ?? 0;
                  });
                },
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
              ButtonTheme(
                  height: 60,
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    child: Text(
                      'Insert Transaction',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      // print('Content = $_content, money amount = $_amount');
                      // Scaffold.of(context).showSnackBar(
                      //   SnackBar(content: Text('Content = $_content, money amount = $_amount'))
                      // );
                      setState(() {
                        _transactions.add(_transaction);
                        _transaction = Transaction(content: '', amount: 0.0);
                        _amountController.text = '';
                        _contentController.text = '';
                      });
                      _scaffoldKey.currentState?.showSnackBar(SnackBar(
                        content: Text(
                            // 'Content = ${_transaction.content}, money amount = ${_transaction.amount}'),
                            'Transaction list = ' + _transactions.toString()),
                        duration: Duration(seconds: 3),
                      ));
                    },
                    textColor: Colors.white,
                    color: Colors.pinkAccent,
                  )),
              Column(
                children: _transactions.map((e) {
                  return ListTile(
                    leading: const Icon(Icons.access_alarm),
                    title: Text(e.content),
                    subtitle: Text('Price: ${e.amount}'),
                    onTap: () {
                      print('tab ${e.content}');
                    },
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
