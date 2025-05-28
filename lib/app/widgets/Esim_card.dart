import 'package:flutter/material.dart';

class EsimCard extends StatelessWidget {
  final String name;
  final String status;
  final int simCount;


  const EsimCard({
    super.key,
    required this.name,
    required this.status,
    required this.simCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Constrain width to allow text wrapping
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.sim_card, color: Colors.red),
              const SizedBox(width: 8),
              Text(
                "eSIM $simCount",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          // Text(
          //   description,
          //   style: const TextStyle(
          //     fontSize: 12,
          //     color: Colors.grey,
          //   ),
          //   softWrap: true,
          //   overflow: TextOverflow.ellipsis,
          //   maxLines: 3, // Limit lines, add ellipsis if too long
          // ),
          // const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
