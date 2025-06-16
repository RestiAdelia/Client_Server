import 'package:flutter/material.dart';
import 'package:sqlitebuku/helper/db_helper.dart';
import 'package:sqlitebuku/model/model_buku.dart';

class AddbukuView extends StatefulWidget {
  const AddbukuView({super.key});

  @override
  State<AddbukuView> createState() => _AddbukuViewState();
}

class _AddbukuViewState extends State<AddbukuView> {
  var _judulBukuController = TextEditingController();
  var _kategoriBukuController = TextEditingController();

  bool _validateJudul = false;
  bool _validateKategori = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Data Buku')),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'add Data Buku',
                  style: TextStyle(

                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _judulBukuController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Masukan Judul Buku',
                    labelText: 'Judul Buku',
                    errorText: _validateJudul
                        ? 'judul tidak boleh kosong'
                        : null,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _kategoriBukuController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Masukan Kategori Buku',
                    labelText: 'Kategori Buku',
                    errorText:
                    _validateKategori ? 'kategori tidak boleh kosong' : null,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        textStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      onPressed: ()  async {
                        setState(() {
                          _judulBukuController.text.isEmpty ? true : _validateJudul = false;
                          _kategoriBukuController.text.isEmpty ? true : _validateKategori = false;
                        });
                        if (_validateJudul == false &&
                            _validateKategori == false) {
                          var _buku = ModelBuku(
                              judulbuku: _judulBukuController.text,
                              kategori: _kategoriBukuController.text);
                          var result = await DatabaseHelper.instance.insertBuku(_buku);
                          Navigator.pop(context, result);
                        }
                        // Aksi saat tombol ditekan
                        _judulBukuController.text =' ';
                        _kategoriBukuController.text =' ';
                      },
                      child: Text(
                        'Save ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        textStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        // Aksi saat tombol ditekan
                        _judulBukuController.text =' ';
                        _kategoriBukuController.text =' ';

                      },
                      child: Text(
                      'Clear ',
                      style: TextStyle(color: Colors.white),
                    ),
                    //),

                    )
                  ],
                )
              ]
          ),
        ),
      ),
    );
  }
}
