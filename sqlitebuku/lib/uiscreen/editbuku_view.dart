import 'package:flutter/material.dart';
import 'package:sqlitebuku/model/model_buku.dart';
import 'package:sqlitebuku/helper/db_helper.dart';

class EditbukuView extends StatefulWidget {
  final ModelBuku buku;

  const EditbukuView({super.key, required this.buku});

  @override
  State<EditbukuView> createState() => _EditbukuViewState();
}

class _EditbukuViewState extends State<EditbukuView> {
  late TextEditingController _judulBukuController;
  late TextEditingController _kategoriBukuController;

  bool _validateJudul = false;
  bool _validateKategori = false;

  @override
  void initState() {
    super.initState();
    _judulBukuController = TextEditingController(text: widget.buku.judulbuku);
    _kategoriBukuController = TextEditingController(text: widget.buku.kategori);
  }

  @override
  void dispose() {
    _judulBukuController.dispose();
    _kategoriBukuController.dispose();
    super.dispose();
  }

  void _updateBuku() async {
    setState(() {
      _validateJudul = _judulBukuController.text.isEmpty;
      _validateKategori = _kategoriBukuController.text.isEmpty;
    });

    if (!_validateJudul && !_validateKategori) {
      ModelBuku updatedBuku = ModelBuku(
        id: widget.buku.id,
        judulbuku: _judulBukuController.text,
        kategori: _kategoriBukuController.text,
      );

      await DatabaseHelper.instance.updateBuku(updatedBuku);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data berhasil diperbarui')),
      );
      Navigator.pop(context); // kembali ke halaman sebelumnya
    }
  }

  void _clearForm() {
    _judulBukuController.clear();
    _kategoriBukuController.clear();
    setState(() {
      _validateJudul = false;
      _validateKategori = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data Buku'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit Buku',
              style: TextStyle(fontSize: 20, color: Colors.teal, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _judulBukuController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Masukan Judul Buku',
                labelText: 'Judul Buku',
                errorText: _validateJudul ? 'Judul Buku tidak boleh kosong' : null,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _kategoriBukuController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Masukan Kategori',
                labelText: 'Kategori Buku',
                errorText: _validateKategori ? 'Kategori tidak boleh kosong' : null,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  onPressed: _updateBuku,
                  child: const Text('Update'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: _clearForm,
                  child: const Text('Clear'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
