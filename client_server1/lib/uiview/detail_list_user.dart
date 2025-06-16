import 'package:flutter/material.dart';
import 'package:client_server1/model/model_users.dart';


class PageUserDetailView extends StatelessWidget {
  final ModelUser user;

  const PageUserDetailView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name ?? 'User Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: ${user.username}', style: TextStyle(fontSize: 16)),
            Text('Email: ${user.email}', style: TextStyle(fontSize: 16)),
            Text('Phone: ${user.phone}', style: TextStyle(fontSize: 16)),
            Text('Website: ${user.website}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text(' Address:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('City: ${user.address.city}'),
            Text('Street: ${user.address.street}'),
            Text('Zipcode: ${user.address.zipcode}'),
            Text('Latitude: ${user.address.geo.lat}'),
            Text('Longitude: ${user.address.geo.lng}'),
            SizedBox(height: 10),
            Text(' 🏢 Company:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Name: ${user.company.name}'),
            Text('Catch Phrase: ${user.company.catchPhrase}'),
          ],
        ),
      ),
    );
  }
}
