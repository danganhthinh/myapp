import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp2/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({required this.transactions});

  ListView _buildListView() {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: (index - 1) % 2 == 0 ? Colors.green : Colors.teal,
            elevation: 10,
            //test
            child: Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(10)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text(
                      transactions[index].content,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'Date: ${DateFormat.yMMMMd().format(transactions[index].creadtedDate)}',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                  ],
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      child: Text(
                        '${transactions[index].amount}\$',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2, style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      padding: const EdgeInsets.all(10),
                    ),
                    Padding(padding: EdgeInsets.only(right: 10))
                  ],
                ))
              ],
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //now how to make this scrollable, let use ListView
    //1 ListView(children: <Widget>[]) =? this loads all children at the same time
    //2 ListView(itemBuilder: ...) =>this loads only visible items
    // 1 ListView(children: )
    return Container(
      height: 500,
      child: this._buildListView(),
    );
  }
}
