import 'transaction_item.dart';

class Transaction {
  final String id;
  final List<TransactionItem> items;
  final int total;
  final DateTime tanggal;
  final String status;
  final String userId;

  const Transaction({
    required this.id,
    required this.items,
    required this.total,
    required this.tanggal,
    required this.status,
    required this.userId,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      items: (json['items'] as List)
          .map((e) => TransactionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int,
      tanggal: DateTime.parse(json['tanggal'] as String),
      status: json['status'] as String,
      userId: json['userId'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'items': items.map((e) => e.toJson()).toList(),
    'total': total,
    'tanggal': tanggal.toIso8601String(),
    'status': status,
    'userId': userId,
  };
}
