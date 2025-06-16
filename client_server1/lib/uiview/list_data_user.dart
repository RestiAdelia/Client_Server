
import 'package:client_server1/model/model_data_user.dart';
import 'package:client_server1/uiview/detail_list_data_user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PageListDataView extends StatefulWidget {
  const PageListDataView({super.key});

  @override
  State<PageListDataView> createState() => _PageListDataViewState();
}

class _PageListDataViewState extends State<PageListDataView> {
  late Future<List<DataUser>?> futureUser;

  Future<List<DataUser>?> getDataUser() async {
    print('getDataUser called ... ');

    try {
      final response = await http.get(
        Uri.parse('https://reqres.in/api/users?page=2'),
        headers: {'x-api-key': 'reqres-free-v1'},
      );

      print('Response body : ${response.body}');

      if (response.statusCode == 200) {
        return modeListDataFromJson(response.body).data;
      } else {
        throw Exception('Failed to load data : ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    futureUser = getDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("List Data User")),
      body: FutureBuilder<List<DataUser>?>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text('No User data found.'));
          } else {
            List<DataUser> datauser = snapshot.data!;

            return ListView.builder(
              itemCount: datauser.length,
              itemBuilder: (context, index) {
                final data = datauser[index];
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: Card(
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          data.avatar ?? "",
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) =>
                          const Icon(Icons.error),
                        ),
                      ),
                      title: Text("${data.firstName} ${data.lastName}",style: TextStyle(color: Colors.blue),),
                      subtitle: Row(
                        children: [
                          const Icon(Icons.email, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            data.email ?? '-', // aman dari null
                            style: TextStyle(
                              color: Colors.black,
                            ), // pastikan warnanya tidak merah
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PageDetailDataUser(user: data),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}