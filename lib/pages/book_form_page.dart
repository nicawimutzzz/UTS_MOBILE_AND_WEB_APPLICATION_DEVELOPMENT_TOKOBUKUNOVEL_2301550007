import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/book_provider.dart';
import '../theme/app_button_styles.dart';
import '../utils/validators.dart';

class BookFormPage extends StatefulWidget {
  final Book? book;

  const BookFormPage({super.key, this.book});

  @override
  State<BookFormPage> createState() => _BookFormPageState();
}

class _BookFormPageState extends State<BookFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _penulisController = TextEditingController();
  final _hargaController = TextEditingController();
  final _stokController = TextEditingController();
  final _deskripsiController = TextEditingController();
  String? _selectedKategori;

  bool get isEdit => widget.book != null;

  @override
  void initState() {
    super.initState();
    if (widget.book != null) {
      _judulController.text = widget.book!.judul;
      _penulisController.text = widget.book!.penulis;
      _hargaController.text = widget.book!.harga.toString();
      _stokController.text = widget.book!.stok.toString();
      _deskripsiController.text = widget.book!.deskripsi;
      _selectedKategori = widget.book!.kategori;
    }
  }

  @override
  void dispose() {
    _judulController.dispose();
    _penulisController.dispose();
    _hargaController.dispose();
    _stokController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedKategori == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih kategori terlebih dahulu')),
      );
      return;
    }

    final provider = context.read<BookProvider>();
    final book = Book(
      id: widget.book?.id ?? provider.generateNextId(),
      judul: _judulController.text.trim(),
      penulis: _penulisController.text.trim(),
      kategori: _selectedKategori!,
      harga: int.parse(_hargaController.text),
      stok: int.parse(_stokController.text),
      deskripsi: _deskripsiController.text.trim(),
    );

    bool success;
    if (isEdit) {
      success = await provider.updateBook(book);
    } else {
      success = await provider.addBook(book);
    }

    if (success && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(isEdit ? 'Buku diperbarui' : 'Buku ditambahkan')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Buku' : 'Tambah Buku')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _judulController,
                decoration: const InputDecoration(labelText: 'Judul', prefixIcon: Icon(Icons.title)),
                validator: (v) => validateRequired(v, 'Judul'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _penulisController,
                decoration: const InputDecoration(labelText: 'Penulis', prefixIcon: Icon(Icons.person_outline)),
                validator: (v) => validateRequired(v, 'Penulis'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedKategori,
                decoration: const InputDecoration(labelText: 'Kategori', prefixIcon: Icon(Icons.category_outlined)),
                items: provider.categories.where((c) => c != 'Semua').map((cat) {
                  return DropdownMenuItem(value: cat, child: Text(cat));
                }).toList(),
                onChanged: (v) => setState(() => _selectedKategori = v),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _hargaController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Harga (Rp)', prefixIcon: Icon(Icons.payments_outlined)),
                      validator: (v) => validatePositiveInt(v, 'Harga'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _stokController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Stok', prefixIcon: Icon(Icons.inventory_2_outlined)),
                      validator: (v) => validatePositiveInt(v, 'Stok'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _deskripsiController,
                decoration: const InputDecoration(labelText: 'Deskripsi', prefixIcon: Icon(Icons.description_outlined)),
                maxLines: 4,
              ),
              const SizedBox(height: 24),
              provider.isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: AppButtonStyles.primary,
                      onPressed: _handleSave,
                      child: Text(isEdit ? 'Simpan Perubahan' : 'Simpan Buku'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
