

// Reusable Activity Tile
import 'package:flutter/material.dart';

class ActivityTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const ActivityTile({super.key, 
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.red),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}