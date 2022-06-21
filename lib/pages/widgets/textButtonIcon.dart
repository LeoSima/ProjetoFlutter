import 'package:flutter/material.dart';

final buttonStyle = TextButton.styleFrom(
  textStyle: const TextStyle(fontSize: 18),
  padding: const EdgeInsets.all(18),
  backgroundColor: Colors.black26,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
    side: const BorderSide(color: Colors.black45),
  ),
);

class TextButtonIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function()? onPressed;

  const TextButtonIcon({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextButton.icon(
        icon: Icon(icon),
        label: Text(label),
        onPressed: onPressed,
        style: buttonStyle,
      ),
    );
  }
}
