/// Format mata uang Rupiah
String formatRupiah(int amount) {
  final str = amount.toString();
  final buffer = StringBuffer();
  for (int i = 0; i < str.length; i++) {
    if (i > 0 && (str.length - i) % 3 == 0) {
      buffer.write('.');
    }
    buffer.write(str[i]);
  }
  return 'Rp ${buffer.toString()}';
}

/// Format tanggal Indonesia: 26 Okt 2026
String formatTanggal(DateTime date) {
  const bulan = [
    'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
    'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
  ];
  return '${date.day} ${bulan[date.month - 1]} ${date.year}';
}

/// Format tanggal lengkap: 26 Oktober 2026
String formatTanggalLengkap(DateTime date) {
  const bulan = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
  ];
  return '${date.day} ${bulan[date.month - 1]} ${date.year}';
}
