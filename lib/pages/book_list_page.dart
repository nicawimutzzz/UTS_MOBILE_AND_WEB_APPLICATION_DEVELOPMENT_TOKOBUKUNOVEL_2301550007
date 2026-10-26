import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/book_card.dart';
import '../widgets/empty_state.dart';
import 'book_detail_page.dart';
import 'book_form_page.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookProvider>().loadBooks();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Buku')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => const BookFormPage())),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari judul atau penulis...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          provider.setSearch('');
                        },
                      )
                    : null,
              ),
              onChanged: provider.setSearch,
            ),
          ),
          // Filter kategori (chips)
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: provider.categories.map((cat) {
                final isSelected = provider.selectedKategori == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (_) => provider.setKategori(cat),
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textMain,
                      fontSize: 12,
                    ),
                    backgroundColor: Colors.white,
                    side: BorderSide(color: AppColors.border),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          // Daftar buku
          Expanded(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.books.isEmpty
                    ? EmptyState(
                        title: 'Buku tidak ditemukan',
                        subtitle: 'Coba kata kunci lain atau hapus filter',
                        icon: Icons.search_off,
                        onAction: () {
                          _searchController.clear();
                          provider.setSearch('');
                          provider.setKategori('Semua');
                        },
                        actionLabel: 'Reset Filter',
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        itemCount: provider.books.length,
                        itemBuilder: (context, index) {
                          final book = provider.books[index];
                          return BookCard(
                            book: book,
                            onTap: () => Navigator.push(context,
                              MaterialPageRoute(builder: (_) => BookDetailPage(book: book))),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
