import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/book_provider.dart';
import '../providers/transaction_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../utils/format.dart';
import '../widgets/book_card.dart';
import '../widgets/empty_state.dart';
import 'book_detail_page.dart';
import 'book_list_page.dart';
import 'transaction_page.dart';
import 'report_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final _pages = <Widget>[
    const _BerandaContent(),
    const BookListPage(),
    const TransactionPage(),
    const ReportPage(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookProvider>().loadBooks();
      context.read<TransactionProvider>().loadHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.book_outlined), label: 'Buku'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long_outlined), label: 'Transaksi'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), label: 'Laporan'),
        ],
      ),
    );
  }
}

class _BerandaContent extends StatelessWidget {
  const _BerandaContent();

  @override
  Widget build(BuildContext context) {
    final bookProvider = context.watch<BookProvider>();
    final authProvider = context.watch<AuthProvider>();
    final txnProvider = context.watch<TransactionProvider>();

    final books = bookProvider.books;
    final recentBooks = books.take(6).toList();
    final lowStockBooks = books.where((b) => b.isLowStock).toList();
    final todayTxns = txnProvider.history.where((t) =>
      t.tanggal.day == DateTime.now().day &&
      t.tanggal.month == DateTime.now().month &&
      t.tanggal.year == DateTime.now().year
    ).toList();
    final todayRevenue = todayTxns.fold<int>(0, (sum, t) => sum + t.total);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Toko Buku Novel'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.read<AuthProvider>().logout(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await bookProvider.loadBooks();
          await txnProvider.loadHistory();
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Buku baru, cerita baru!',
                    style: AppTextStyles.h2.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Selamat datang, ${authProvider.user?.nama ?? "Pengguna"}!',
                    style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Dashboard ringkasan
            Row(
              children: [
                _summaryCard(
                  'Penjualan Hari Ini',
                  formatRupiah(todayRevenue),
                  Icons.payments_outlined,
                  AppColors.successBg,
                  AppColors.success,
                ),
                const SizedBox(width: 12),
                _summaryCard(
                  'Transaksi Hari Ini',
                  '${todayTxns.length}',
                  Icons.receipt_outlined,
                  AppColors.infoBg,
                  AppColors.info,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _summaryCard(
                  'Total Buku',
                  '${books.length}',
                  Icons.book_outlined,
                  AppColors.primaryBg,
                  AppColors.primary,
                ),
                const SizedBox(width: 12),
                _summaryCard(
                  'Stok Menipis',
                  '${lowStockBooks.length}',
                  Icons.warning_amber_outlined,
                  AppColors.warningBg,
                  AppColors.warning,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Pintasan kategori
            Text('Kategori', style: AppTextStyles.h2),
            const SizedBox(height: 8),
            SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: bookProvider.categories.map((cat) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Chip(
                      label: Text(cat, style: const TextStyle(fontSize: 12)),
                      backgroundColor: AppColors.primaryBg,
                      side: BorderSide.none,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            // Rekomendasi novel
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Rekomendasi Novel', style: AppTextStyles.h2),
                TextButton(
                  onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const BookListPage())),
                  child: const Text('Lihat Semua'),
                ),
              ],
            ),
            const SizedBox(height: 8),

            if (bookProvider.isLoading)
              const Center(child: Padding(
                padding: EdgeInsets.all(40),
                child: CircularProgressIndicator(),
              ))
            else if (recentBooks.isEmpty)
              const EmptyState(
                title: 'Belum ada buku',
                subtitle: 'Tambahkan buku untuk mulai menjual',
                icon: Icons.book_outlined,
              )
            else
              ...recentBooks.map((book) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: BookCard(
                  book: book,
                  onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => BookDetailPage(book: book))),
                ),
              )),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard(String label, String value, IconData icon, Color bg, Color fg) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: fg, size: 20),
            const SizedBox(height: 6),
            Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: fg)),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(fontSize: 10, color: fg.withOpacity(0.8))),
          ],
        ),
      ),
    );
  }
}
