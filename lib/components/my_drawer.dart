import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  void logoutUser() {
    FirebaseAuth.instance.signOut();
  }

  void navigatePage(String routeName) {
    Navigator.pop(context);
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          bottom: 15.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const DrawerHeader(
                  child: Icon(Icons.newspaper),
                ),
                ListTile(
                  onTap: () => Navigator.pop(context),
                  leading: const Icon(
                    Icons.home,
                  ),
                  title: const Text(
                    "H O M E",
                  ),
                ),
                ListTile(
                  onTap: () => navigatePage("/profile_page"),
                  leading: Icon(
                    Icons.person,
                  ),
                  title: const Text(
                    "P R O F I L E",
                  ),
                ),
                ListTile(
                  onTap: () => navigatePage("/user_page"),
                  leading: Icon(
                    Icons.group,
                  ),
                  title: const Text(
                    "U S E R S",
                  ),
                ),
              ],
            ),
            ListTile(
              onTap: logoutUser,
              leading: Icon(Icons.logout),
              title: const Text(
                "L O G O U T",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
