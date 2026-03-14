class TransactionModel {
  final String id;
  final String type; // income or expense
  final double amount;
  final String description;
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.type,
    required this.amount,
    required this.description,
    required this.date,
  });
}