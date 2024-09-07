import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimal_socialmedia/components/my_drawer.dart';
import 'package:minimal_socialmedia/components/my_post_button.dart';
import 'package:minimal_socialmedia/components/my_textfield.dart';
import 'package:minimal_socialmedia/database/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  TextEditingController newPostText = TextEditingController();
  final FireStoreDatabase database = FireStoreDatabase();
  void postMessage() {
    if (newPostText.text.isNotEmpty) {
      database.addPost(newPostText.text);
      newPostText.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Center(
          child: Text(
            "W A L L",
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(
              25.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: MyTextfield(
                    labelText: "Write something...",
                    obsecureText: false,
                    controller: newPostText,
                  ),
                ),
                MyPostButton(
                  onTap: postMessage,
                ),
              ],
            ),
          ),
          StreamBuilder(
            stream: database.getPostsStream(),
            builder: (context, snapshot) {
              // show loding circle
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              // get all posts
              final posts = snapshot.data!.docs;

              // no data check
              if (snapshot.data == null || posts.isEmpty) {
                return const Center(
                  child: Text("The post is empty!!!"),
                );
              }
              // return posts list
              return Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    String message = post["postMessage"];
                    String userEmail = post["userEmail"];
                    Timestamp timestamp = post["timestamp"];
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                        ),
                        child: ListTile(
                          title: Text(message),
                          subtitle: Text(userEmail),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
