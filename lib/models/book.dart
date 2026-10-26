class Book {
  final String id;
  final String judul;
  final String penulis;
  final String kategori;
  final int harga;
  final int stok;
  final String sampul;
  final String deskripsi;

  const Book({
    required this.id,
    required this.judul,
    required this.penulis,
    required this.kategori,
    required this.harga,
    required this.stok,
    this.sampul = '',
    this.deskripsi = '',
  });

  Book copyWith({
    String? id,
    String? judul,
    String? penulis,
    String? kategori,
    int? harga,
    int? stok,
    String? sampul,
    String? deskripsi,
  }) {
    return Book(
      id: id ?? this.id,
      judul: judul ?? this.judul,
      penulis: penulis ?? this.penulis,
      kategori: kategori ?? this.kategori,
      harga: harga ?? this.harga,
      stok: stok ?? this.stok,
      sampul: sampul ?? this.sampul,
      deskripsi: deskripsi ?? this.deskripsi,
    );
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as String,
      judul: json['judul'] as String,
      penulis: json['penulis'] as String,
      kategori: json['kategori'] as String,
      harga: json['harga'] as int,
      stok: json['stok'] as int,
      sampul: json['sampul'] as String? ?? '',
      deskripsi: json['deskripsi'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'judul': judul,
    'penulis': penulis,
    'kategori': kategori,
    'harga': harga,
    'stok': stok,
    'sampul': sampul,
    'deskripsi': deskripsi,
  };

  bool get isAvailable => stok > 0;
  bool get isLowStock => stok > 0 && stok < 5;
}
