import 'package:flutter/material.dart';
import 'models/transaction.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(SmartFinanceApp());
}

class SmartFinanceApp extends StatefulWidget {
  @override
  State<SmartFinanceApp> createState() => _SmartFinanceAppState();
}

class _SmartFinanceAppState extends State<SmartFinanceApp> {
  List<TransactionModel> transactions = [];

  void addTransaction(TransactionModel tx) {
    setState(() {
      transactions.add(tx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF111111),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF1C1C1E),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: HomeScreen(
        transactions: transactions,
        addTransaction: addTransaction,
      ),
    );
  }
}