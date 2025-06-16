import 'package:flutter/material.dart';
import 'package:sqlitebuku/helper/db_helper.dart';
import 'package:sqlitebuku/model/model_buku.dart';
import 'package:sqlitebuku/uiscreen/addbuku_view.dart';
import 'package:sqlitebuku/uiscreen/editbuku_view.dart';

class ListdatabukuView extends StatefulWidget {
  const ListdatabukuView({super.key});

  @override
  State<ListdatabukuView> createState() => _ListdatabukuViewState();
}

class _ListdatabukuViewState extends State<ListdatabukuView> {
  List<ModelBuku> _buku = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    DatabaseHelper.instance.dummyBuku().then((_) {
      _fetchDataBuku();
    });
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _fetchDataBuku() async {
    final bukuMaps = await DatabaseHelper.instance.quaryAllBuku();
    setState(() {
      _buku = bukuMaps.map((map) => ModelBuku.fromMap(map)).toList();
      isLoading = false;
    });
  }

  Future<void> _deleteFormDialog(BuildContext context, int bukuId) async {
    return showDialog(
      context: context,
      builder: (param) {
        return AlertDialog(
          title:  Text('Hapus Data'),
          content: const Text(
            'Are You Sure Delete This?',
            style: TextStyle(color: Colors.red, fontSize: 15),
          ),
          actions: [
            TextButton(
        style: TextButton.styleFrom(
        foregroundColor: Colors.white,
          backgroundColor: Colors.green,
            ),
          onPressed: () => Navigator.pop(context),
              child:  Text('Batal'),
            ),
            TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                ),
              onPressed: () async {
                var result = await DatabaseHelper.instance.deleteBuku(bukuId);
                if (result !=null){
                  Navigator.pop(context);
                  _fetchDataBuku();
                  _showSuccessSnackbar('Buku Id ${bukuId} telah berhasil dihapus!');
                }
              }, child: Text('Delete') )

          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Data Buku"),
        actions: [
          IconButton(
            onPressed: _fetchDataBuku,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: ListView.builder(
                itemCount: _buku.length,
                itemBuilder: (context, index) {
                  final buku = _buku[index];
                  return ListTile(
                    title: Text(buku.judulbuku),
                    subtitle: Text(buku.kategori),
                    onLongPress: () {
                      _deleteFormDialog(context, buku.id!);
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.black),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditbukuView( buku: buku), // kirim data buku
                          ),
                        ).then((_) => _fetchDataBuku());
                      },

                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddbukuView()),
          ).then((_) => _fetchDataBuku());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
