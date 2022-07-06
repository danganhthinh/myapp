import 'package:flutter/material.dart';

class Transaction {
  String content;
  double amount;
  DateTime creadtedDate;

  Transaction({required this.content, required this.amount, required this.creadtedDate});

 @override
  String toString() {
    // TODO: implement toString
    return 'content $content, amount: $amount';
  }
}