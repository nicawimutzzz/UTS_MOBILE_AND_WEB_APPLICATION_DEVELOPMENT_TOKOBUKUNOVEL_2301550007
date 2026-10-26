import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/transaction_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_button_styles.dart';
import '../theme/app_text_styles.dart';
import '../utils/format.dart';
import '../widgets/empty_state.dart';
import '../widgets/quantity_picker.dart';
import 'transaction_confirm_page.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Transaksi Penjualan')),
      body: provider.isCartEmpty
          ? const EmptyState(
              title: 'Keranjang masih kosong',
              subtitle: 'Pilih buku dari Daftar Buku untuk menambahkan',
              icon: Icons.shopping_cart_outlined,
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: provider.cart.length,
                    itemBuilder: (context, index) {
                      final item = provider.cart[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 48,
                                height: 64,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryBg,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(Icons.book, size: 20, color: AppColors.primaryLight),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.judul, style: AppTextStyles.h3.copyWith(fontSize: 14), maxLines: 2, overflow: TextOverflow.ellipsis),
                                    const SizedBox(height: 4),
                                    Text(formatRupiah(item.harga), style: TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        QuantityPicker(
                                          initialQty: item.qty,
                                          onChanged: (q) => provider.updateCartQty(item.bookId, q),
                                        ),
                                        Text(formatRupiah(item.subtotal), style: AppTextStyles.price.copyWith(fontSize: 15)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: AppColors.error, size: 20),
                                onPressed: () => provider.removeFromCart(item.bookId),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Error message
                if (provider.errorMessage.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.errorBg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(provider.errorMessage, style: TextStyle(color: AppColors.error, fontSize: 13)),
                  ),
                // Total & Checkout
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: AppColors.border)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total (${provider.cartCount} item)', style: AppTextStyles.h2),
                          Text(formatRupiah(provider.cartTotal), style: AppTextStyles.h2.copyWith(color: AppColors.primary)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      provider.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              style: AppButtonStyles.primary,
                              onPressed: () async {
                                final user = context.read<AuthProvider>().user;
                                if (user == null) return;
                                final success = await provider.checkout(user);
                                if (success && context.mounted) {
                                  Navigator.push(context,
                                    MaterialPageRoute(builder: (_) => const TransactionConfirmPage()),
                                  );
                                }
                              },
                              child: const Text('Simpan Transaksi'),
                            ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
