import 'dart:convert';
import 'package:client_server1/uiview/detail_list_user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:client_server1/model/model_users.dart';

class PageListUserView extends StatefulWidget {
  const PageListUserView({super.key});

  @override
  State<PageListUserView> createState() => _PageListUserViewState();
}

class _PageListUserViewState extends State<PageListUserView> {
  bool isLoading = false;
  List<ModelUser> listUsers = [];

  Future<void> getUser() async {
    try {
      setState(() {
        isLoading = true;
      });

      http.Response res = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
      );

      if (res.statusCode == 200) {
        var decodedData = json.decode(res.body);
        setState(() {
          listUsers.clear();
          for (var i in decodedData) {
            listUsers.add(ModelUser.fromJson(i));
          }
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Users')),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: listUsers.length,
                itemBuilder: (context, index) {
                  final user = listUsers[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Card(
                      child: ListTile(
                        title: Text(
                          user.name,
                          style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.username),
                            Text(user.email),
                            Text("City: ${user.address.city}"),
                            Text("Company: ${user.company.name}"),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => PageUserDetailView(
                                    user: listUsers[index],
                                  ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
