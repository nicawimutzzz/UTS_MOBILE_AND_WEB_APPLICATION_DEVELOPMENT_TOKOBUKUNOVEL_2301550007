import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/report_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../utils/format.dart';
import '../widgets/empty_state.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  DateTime? _fromDate;
  DateTime? _toDate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReportProvider>().loadReport();
    });
  }

  Future<void> _pickDate(BuildContext context, bool isFrom) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          _fromDate = picked;
        } else {
          _toDate = picked;
        }
      });
      context.read<ReportProvider>().loadReport(from: _fromDate, to: _toDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReportProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Laporan Penjualan')),
      body: Column(
        children: [
          // Filter periode
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _pickDate(context, true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.textSecondary),
                          const SizedBox(width: 8),
                          Text(
                            _fromDate != null ? formatTanggal(_fromDate!) : 'Dari tanggal',
                            style: AppTextStyles.bodySecondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: () => _pickDate(context, false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.textSecondary),
                          const SizedBox(width: 8),
                          Text(
                            _toDate != null ? formatTanggal(_toDate!) : 'Sampai tanggal',
                            style: AppTextStyles.bodySecondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (_fromDate != null || _toDate != null)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _fromDate = null;
                        _toDate = null;
                      });
                      context.read<ReportProvider>().loadReport();
                    },
                  ),
              ],
            ),
          ),
          // Summary cards
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _summaryCard('Pendapatan', formatRupiah(provider.totalPendapatan), Icons.payments, AppColors.successBg, AppColors.success),
                const SizedBox(width: 12),
                _summaryCard('Transaksi', '${provider.jumlahTransaksi}', Icons.receipt, AppColors.infoBg, AppColors.info),
                const SizedBox(width: 12),
                _summaryCard('Buku Terjual', '${provider.totalBukuTerjual}', Icons.book, AppColors.primaryBg, AppColors.primary),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Daftar transaksi
          Expanded(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.transactions.isEmpty
                    ? const EmptyState(
                        title: 'Belum ada transaksi',
                        subtitle: 'Transaksi yang dicatat akan muncul di sini',
                        icon: Icons.receipt_long_outlined,
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: provider.transactions.length,
                        itemBuilder: (context, index) {
                          final txn = provider.transactions[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              leading: CircleAvatar(
                                backgroundColor: AppColors.primaryBg,
                                child: const Icon(Icons.receipt, color: AppColors.primary, size: 20),
                              ),
                              title: Text(txn.id, style: AppTextStyles.h3.copyWith(fontSize: 14)),
                              subtitle: Text('${formatTanggal(txn.tanggal)} • ${txn.items.length} item'),
                              trailing: Text(formatRupiah(txn.total), style: AppTextStyles.price.copyWith(fontSize: 14)),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _summaryCard(String label, String value, IconData icon, Color bg, Color fg) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(icon, color: fg, size: 20),
            const SizedBox(height: 4),
            Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: fg), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(fontSize: 10, color: fg.withOpacity(0.8)), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
