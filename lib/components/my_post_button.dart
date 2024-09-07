import 'package:flutter/material.dart';

class MyPostButton extends StatelessWidget {
  void Function()? onTap;
  MyPostButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          left: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
        padding: const EdgeInsets.all(15),
        child: const Center(
          child: Icon(
            Icons.done,
          ),
        ),
      ),
    );
  }
}
