import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimal_socialmedia/components/my_backbutton.dart';
import 'package:minimal_socialmedia/helper/helper_functions.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            displayMessageToUser("Some error occured!!!", context);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data == null) {
            return const Text("No data found!!!");
          }
          final users = snapshot.data!.docs;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  top: 60,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MyBackbutton(),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      title: Text(user["username"]),
                      subtitle: Text(user["email"]),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
