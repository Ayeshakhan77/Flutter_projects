import 'package:flutter/material.dart';
import '../models/transaction.dart';

class AddIncomeScreen extends StatefulWidget {
  final Function(TransactionModel) addTransaction;

  AddIncomeScreen(this.addTransaction);

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  final amountController = TextEditingController();
  final descController = TextEditingController();

  void submit() {
    final amount = double.tryParse(amountController.text);

    if (amount == null || amount <= 0 || descController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid input")));
      return;
    }

    widget.addTransaction(TransactionModel(
      id: DateTime.now().toString(),
      type: "income",
      amount: amount,
      description: descController.text,
      date: DateTime.now(),
    ));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return buildForm("Add Income", Color(0xFF39FF14));
  }

  Widget buildForm(String title, Color color) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title,
            style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Amount",
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: descController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Description",
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: color),
              onPressed: submit,
              child:
                  Text("Save", style: TextStyle(color: Colors.black)),
            )
          ],
        ),
      ),
    );
  }
}
