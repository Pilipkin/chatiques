import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData leftIcon;
  final IconData rightIcon;
  final VoidCallback onPressed;
  final Color color;
  final double width;
  final double height;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.leftIcon = Icons.hourglass_empty,
    this.rightIcon = Icons.hourglass_empty,
    this.color = Colors.blue,
    this.width = 200,
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leftIcon != Icons.hourglass_empty) Icon(leftIcon),
            if (leftIcon != Icons.hourglass_empty) const SizedBox(width: 5),
            Text(text),
            if (rightIcon != Icons.hourglass_empty) const SizedBox(width: 5),
            if (rightIcon != Icons.hourglass_empty) Icon(rightIcon),
          ],
        ),
      ),
    );
  }
}
