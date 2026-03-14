import 'package:flutter/material.dart';
import 'dart:math';
import '../models/transaction.dart';
import 'add_income_screen.dart';
import 'add_expense_screen.dart';

class HomeScreen extends StatefulWidget {
  final List<TransactionModel> transactions;
  final Function(TransactionModel) addTransaction;

  HomeScreen({required this.transactions, required this.addTransaction});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = "";

  double get totalIncome => widget.transactions
      .where((t) => t.type == "income")
      .fold(0.0, (sum, item) => sum + item.amount);

  double get totalExpense => widget.transactions
      .where((t) => t.type == "expense")
      .fold(0.0, (sum, item) => sum + item.amount);

  double get balance => totalIncome - totalExpense;

  List<double> get balanceHistory {
    double running = 0;
    List<double> history = [];

    for (var tx in widget.transactions) {
      if (tx.type == "income") {
        running += tx.amount;
      } else {
        running -= tx.amount;
      }
      history.add(running);
    }

    return history;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = widget.transactions.where((t) {
      return t.description
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Smart Finance Tracker",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            balanceCard(),
            SizedBox(height: 25),
            lineChart(),
            SizedBox(height: 25),
            searchField(),
            SizedBox(height: 15),
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Text(
                        "No transactions found",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (_, index) {
                        final tx = filtered[index];
                        return modernTile(tx);
                      },
                    ),
            )
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.greenAccent,
            child: Icon(Icons.add, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      AddIncomeScreen(widget.addTransaction),
                ),
              );
            },
          ),
          SizedBox(height: 12),
          FloatingActionButton(
            backgroundColor: Colors.redAccent,
            child: Icon(Icons.remove),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      AddExpenseScreen(widget.addTransaction),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget balanceCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text("Current Balance",
              style: TextStyle(color: Colors.grey)),
          SizedBox(height: 10),
          Text(
            balance.toStringAsFixed(2),
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: balance >= 0
                    ? Colors.greenAccent
                    : Colors.redAccent),
          ),
        ],
      ),
    );
  }

  Widget modernTile(TransactionModel tx) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(tx.description,
              style: TextStyle(fontSize: 16)),
          Text(
            "${tx.type == "income" ? "+" : "-"} ${tx.amount}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: tx.type == "income"
                  ? Colors.greenAccent
                  : Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }

  Widget searchField() {
    return TextField(
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: "Search...",
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Color(0xFF1C1C1E),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none),
      ),
      onChanged: (val) {
        setState(() {
          searchQuery = val;
        });
      },
    );
  }

  Widget lineChart() {
    if (balanceHistory.isEmpty) return SizedBox();

    return Container(
      height: 200,
      width: double.infinity,
      child: CustomPaint(
        painter: BalanceChartPainter(balanceHistory),
      ),
    );
  }
}

class BalanceChartPainter extends CustomPainter {
  final List<double> data;

  BalanceChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    Paint linePaint = Paint()
      ..color = Colors.greenAccent
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    double maxVal = data.reduce(max);
    double minVal = data.reduce(min);

    double range = maxVal - minVal;
    if (range == 0) range = 1;

    Path path = Path();

    for (int i = 0; i < data.length; i++) {
      double x = i * (size.width / (data.length - 1));
      double y =
          size.height - ((data[i] - minVal) / range) * size.height;

      if (i == 0)
        path.moveTo(x, y);
      else
        path.lineTo(x, y);
    }

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}