import 'package:flutter/material.dart';

class RecapCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Map<String, String> data;

  const RecapCard({
    super.key,
    required this.title,
    required this.icon,
    required this.data,
  });

  Widget buildKeyValue(String key, String value) {
    return Container(
      
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // This will space out the children
          children: [
            Text(key, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(value),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, color: Colors.red),
                    const SizedBox(width: 8),
                    Text(title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    const Icon(Icons.edit, size: 18, color: Colors.red),
                  ],
                ),
                const Divider(height: 24),
                ...data.entries
                    .map((e) => buildKeyValue(e.key, e.value))
                    ,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
