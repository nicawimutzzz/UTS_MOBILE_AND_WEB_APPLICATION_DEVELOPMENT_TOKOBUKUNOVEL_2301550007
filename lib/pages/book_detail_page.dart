import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/transaction_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_button_styles.dart';
import '../theme/app_text_styles.dart';
import '../utils/format.dart';
import '../widgets/quantity_picker.dart';

class BookDetailPage extends StatefulWidget {
  final Book book;

  const BookDetailPage({super.key, required this.book});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  int _qty = 1;

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    final txnProvider = context.watch<TransactionProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(book.judul, maxLines: 1, overflow: TextOverflow.ellipsis)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sampul
            Center(
              child: Container(
                width: 160,
                height: 220,
                decoration: BoxDecoration(
                  color: AppColors.primaryBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Icon(Icons.book, size: 64, color: AppColors.primaryLight),
              ),
            ),
            const SizedBox(height: 20),
            // Kategori
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(book.kategori, style: TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 8),
            // Judul
            Text(book.judul, style: AppTextStyles.h1),
            const SizedBox(height: 4),
            Text(book.penulis, style: AppTextStyles.bodySecondary),
            const SizedBox(height: 16),
            // Harga
            Text(formatRupiah(book.harga), style: AppTextStyles.price.copyWith(fontSize: 22)),
            const SizedBox(height: 16),
            // Stok
            Row(
              children: [
                const Icon(Icons.inventory_2_outlined, size: 18, color: AppColors.textSecondary),
                const SizedBox(width: 6),
                if (book.stok == 0)
                  Text('Stok tidak tersedia', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.w600))
                else if (book.isLowStock)
                  Text('Stok: ${book.stok} (menipis)', style: TextStyle(color: AppColors.warning, fontWeight: FontWeight.w600))
                else
                  Text('Stok: ${book.stok}', style: TextStyle(color: AppColors.success, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 20),
            // Deskripsi
            Text('Deskripsi', style: AppTextStyles.h3),
            const SizedBox(height: 6),
            Text(book.deskripsi, style: AppTextStyles.body),
            const SizedBox(height: 28),

            // Quantity & Tombol
            if (book.isAvailable) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Jumlah', style: AppTextStyles.h3),
                  QuantityPicker(
                    maxQty: book.stok,
                    onChanged: (q) => setState(() => _qty = q),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: AppButtonStyles.primary,
                onPressed: () {
                  txnProvider.addToCart(book, _qty);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${book.judul} ($_qty) ditambah ke keranjang'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Tambah ke Keranjang'),
              ),
            ] else ...[
              ElevatedButton(
                style: AppButtonStyles.disabled,
                onPressed: null,
                child: const Text('Stok Habis'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
