import 'package:flutter/material.dart';
import 'package:myapp2/transaction_list.dart';
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
  Transaction _transaction =
      Transaction(content: '', amount: 0.0, creadtedDate: DateTime.now());
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

  void _insertTransaction() {
    if (_transaction.content.isEmpty ||
        _transaction.amount == 0.0 ||
        _transaction.amount.isNaN) {
      return;
    }
    _transactions.add(_transaction);
    _transaction.creadtedDate = DateTime.now();
    _transaction =
        Transaction(content: '', amount: 0.0, creadtedDate: DateTime.now());
    _amountController.text = '';
    _contentController.text = '';
  }

  void _onButtonShowModalSheet() {
    showModalBottomSheet(
        context: this.context,
        builder: (context) {
          return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(labelText: 'Content'),
                  controller: _contentController,
                  onChanged: (text) {
                    setState(() {
                      // _content = text;
                      _transaction.content = text;
                    });
                  },
                ),
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Amount(money)'),
                    controller: _amountController,
                    onChanged: (text) {
                      setState(() {
                        // _amount = double.tryParse(text) ?? 0;
                        _transaction.amount = double.tryParse(text) ?? 0;
                      });
                    },
                  )),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                        child: SizedBox(
                      child: RaisedButton(
                          color: Colors.pinkAccent,
                          child: Text('Save'),
                          onPressed: () {
                            setState(() {
                              this._insertTransaction();
                            });
                            Navigator.of(context).pop();
                          }),
                      height: 50,
                    )),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Expanded(
                        child: SizedBox(
                      child: RaisedButton(
                          color: Colors.teal,
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      height: 50,
                    )),
                  ],
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    //now how to display a DataTime?
    DateTime now = new DateTime.now();
    DateTime someDate = new DateTime(2022, 5, 2);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction manager'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                this._onButtonShowModalSheet();
                // setState(() {
                //   this._insertTransaction();
                // });
              },
              icon: Icon(Icons.add))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add transaction',
        child: Icon(Icons.add),
        onPressed: () {
          this._onButtonShowModalSheet();

          // setState(() {
          //   this._insertTransaction();
          // });
        },
        backgroundColor: Theme.of(context).primaryColor,
      ),
      key: _scaffoldKey,
      body: SafeArea(
        minimum: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
              ButtonTheme(
                  height: 60,
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    child: Text(
                      'Insert Transaction ó ó ó ó',
                      style: TextStyle(fontSize: 18, fontFamily: 'Pacifico'),
                    ),
                    onPressed: () {
                      // print('Content = $_content, money amount = $_amount');
                      // Scaffold.of(context).showSnackBar(
                      //   SnackBar(content: Text('Content = $_content, money amount = $_amount'))
                      // );
                      this._onButtonShowModalSheet();
                      // setState(() {
                      //   this._insertTransaction();
                      // });
                      _scaffoldKey.currentState?.showSnackBar(SnackBar(
                        content: Text(
                            // 'Content = ${_transaction.content}, money amount = ${_transaction.amount}'),
                            'Transaction list = ' + _transactions.toString()),
                        duration: Duration(seconds: 3),
                      ));
                    },
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                  )),
              TransactionList(
                transactions: _transactions,
              )
            ],
          ),
        ),
      ),
    );
  }
}
