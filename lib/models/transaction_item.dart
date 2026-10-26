class TransactionItem {
  final String bookId;
  final String judul;
  final int qty;
  final int harga;

  const TransactionItem({
    required this.bookId,
    required this.judul,
    required this.qty,
    required this.harga,
  });

  int get subtotal => qty * harga;

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    return TransactionItem(
      bookId: json['bookId'] as String,
      judul: json['judul'] as String,
      qty: json['qty'] as int,
      harga: json['harga'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'bookId': bookId,
    'judul': judul,
    'qty': qty,
    'harga': harga,
  };
}
