import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreDatabase {
  //current logged in user
  User? user = FirebaseAuth.instance.currentUser;

// get collection of posts from the firestore
  final CollectionReference posts =
      FirebaseFirestore.instance.collection("Posts");

// post something
  Future<void> addPost(String message) {
    return posts.add({
      "userEmail": user!.email,
      "postMessage": message,
      'timestamp': Timestamp.now(),
    });
  }

  // read posts from the database
  Stream<QuerySnapshot> getPostsStream() {
    final postsStream = FirebaseFirestore.instance
        .collection("Posts")
        .orderBy("timestamp", descending: true)
        .snapshots();
    return postsStream;
  }
}
