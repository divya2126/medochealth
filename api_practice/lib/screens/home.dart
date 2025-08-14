
import 'package:flutter/material.dart';
import 'package:api_practice/models/user.dart';
import 'package:api_practice/services/user_api.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest Api call'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            
            return ListTile(

              //leading: ClipRRect(
              // borderRadius: BorderRadius.circular(100),
              // child:Image.network(imageUrl),
              //),
              title: Text(user.fullName),
              subtitle: Text(user.location.country),
              //tileColor: color,
              //subtitle: Text(email),
            );
          }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: fetchUsers,
      // ),
    );
  }

  Future <void> fetchUsers() async {
    final response = await UserApi.fetchUsers();
    setState(() {
      users = response;
    });
  }
}