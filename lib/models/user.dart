class User {
  final String id;
  final String nama;
  final String email;
  final String password;
  final String peran; // 'pemilik' atau 'pegawai'

  const User({
    required this.id,
    required this.nama,
    required this.email,
    required this.password,
    required this.peran,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      nama: json['nama'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      peran: json['peran'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nama': nama,
    'email': email,
    'password': password,
    'peran': peran,
  };

  bool get isPemilik => peran == 'pemilik';
  bool get isPegawai => peran == 'pegawai';
}
