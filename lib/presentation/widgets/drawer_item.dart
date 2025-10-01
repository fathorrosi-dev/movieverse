import 'package:flutter/material.dart';
import 'package:movieverse/main.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {super.key,
      required this.name,
      required this.icon,
      required this.onPressed});

  final String name;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.blue.shade700,
      onTap: onPressed,
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
            const SizedBox(
              width: 40,
            ),
            Text(name, style: $styles.text.bodyLarge),
          ],
        ),
      ),
    );
  }
}
