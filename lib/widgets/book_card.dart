import 'package:flutter/material.dart';
import '../models/book.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../utils/format.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback? onTap;

  const BookCard({super.key, required this.book, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover placeholder
              Container(
                width: 60,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primaryBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.book, color: AppColors.primaryLight, size: 28),
              ),
              const SizedBox(width: 12),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.judul,
                      style: AppTextStyles.h3.copyWith(fontSize: 15),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(book.penulis, style: AppTextStyles.bodySecondary),
                    const SizedBox(height: 4),
                    Text(formatRupiah(book.harga), style: AppTextStyles.price),
                    const SizedBox(height: 6),
                    _buildStockBadge(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStockBadge() {
    if (book.stok == 0) {
      return _badge('Stok Habis', AppColors.errorBg, AppColors.error);
    } else if (book.isLowStock) {
      return _badge('Stok: ${book.stok}', AppColors.warningBg, AppColors.warning);
    } else {
      return _badge('Stok: ${book.stok}', AppColors.successBg, AppColors.success);
    }
  }

  Widget _badge(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
    );
  }
}
