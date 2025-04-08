import 'package:flutter/material.dart';
import '../const.dart';

class MyButton extends StatelessWidget {
  final String child;
  final VoidCallback onTap;

  const MyButton({Key? key, required this.child, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color buttonColor;
    switch (child) {
      case 'C':
        buttonColor = Colors.green;
        break;
      case 'DEL':
        buttonColor = Colors.red;
        break;
      case '=':
        buttonColor = Colors.amber;
        break;
      default:
        buttonColor = Colors.deepPurple[400]!;
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 2,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Center(
            child: Text(child, style: whiteTextStyle.copyWith(fontSize: 24)),
          ),
        ),
      ),
    );
  }
}