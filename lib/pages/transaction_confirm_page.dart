import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_button_styles.dart';
import '../theme/app_text_styles.dart';
import '../utils/format.dart';
import 'home_page.dart';

class TransactionConfirmPage extends StatelessWidget {
  const TransactionConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    final txn = context.watch<TransactionProvider>().lastTransaction;

    return Scaffold(
      appBar: AppBar(title: const Text('Konfirmasi Transaksi'), automaticallyImplyLeading: false),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon sukses
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.successBg,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: AppColors.success, size: 48),
              ),
              const SizedBox(height: 20),
              Text('Transaksi Berhasil!', style: AppTextStyles.h1),
              const SizedBox(height: 8),
              Text(
                'Transaksi telah tersimpan dan stok buku diperbarui',
                style: AppTextStyles.bodySecondary,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              if (txn != null) ...[
                _infoCard(txn.id, formatTanggal(txn.tanggal)),
                const SizedBox(height: 12),
                ...txn.items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${item.judul} x${item.qty}',
                          style: AppTextStyles.body,
                        ),
                      ),
                      Text(formatRupiah(item.subtotal), style: AppTextStyles.body),
                    ],
                  ),
                )),
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: AppTextStyles.h2),
                    Text(formatRupiah(txn.total), style: AppTextStyles.h2.copyWith(color: AppColors.primary)),
                  ],
                ),
              ],
              const SizedBox(height: 32),
              ElevatedButton(
                style: AppButtonStyles.primary,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                    (route) => false,
                  );
                },
                child: const Text('Selesai'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard(String id, String tanggal) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primaryBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('No. Transaksi', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              Text(id, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Tanggal', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              Text(tanggal, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}
