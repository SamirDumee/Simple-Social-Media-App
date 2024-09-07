import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_socialmedia/components/my_button.dart';
import 'package:minimal_socialmedia/components/my_textfield.dart';
import 'package:minimal_socialmedia/helper/helper_functions.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  void registerUser() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context);
      displayMessageToUser("The password does not match!!!", context);
    } else {
      try {
        UserCredential? userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        createUserDocument(userCredential);
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayMessageToUser(e.code, context);
      }
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential) async {
    print('User created');

    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        "email": userCredential.user!.email,
        "username": usernameController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person,
                size: 50,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("S O C I A L  M E D I A"),
              const SizedBox(
                height: 20,
              ),
              MyTextfield(
                labelText: "Username",
                obsecureText: false,
                controller: usernameController,
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextfield(
                labelText: "Email",
                obsecureText: false,
                controller: emailController,
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextfield(
                labelText: "Password",
                obsecureText: true,
                controller: passwordController,
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextfield(
                labelText: "Confirm Password",
                obsecureText: true,
                controller: confirmPasswordController,
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forget Password?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                text: "Register",
                onTap: registerUser,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("Are you already signedup?"),
                  InkWell(
                    onTap: widget.onTap,
                    child: const Text(
                      " Login Here",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
