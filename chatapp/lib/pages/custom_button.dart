 import "package:flutter/material.dart";

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  const MyButton({super.key, required this.text, this.onTap});
  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(
      onTap: onTap,
      child: Container(
              decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.circular(8)),
              width: double.infinity,
              height: 50,
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Color(0xFF2B475E),
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
            )
           ),
    );
  }
}
