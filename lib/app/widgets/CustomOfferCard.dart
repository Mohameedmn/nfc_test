import 'package:flutter/material.dart';

class CustomOfferCard extends StatelessWidget {
  final String name;
  final int oldData;
  final int newData;
  final String price;
  final String duration;
  final String description;

  const CustomOfferCard({
    super.key,
    required this.name,
    required this.oldData,
    required this.newData,
    required this.price,
    required this.duration,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // ✅ Make it responsive
      margin: const EdgeInsets.symmetric(vertical: 8), // ✅ No horizontal overflow
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded( // ✅ Prevent text from overflowing
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
          const SizedBox(height: 10),

          // Promo Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.local_offer, size: 16, color: Colors.white),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    description,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Data Info (fixed overflow issue)
          Row(
            children: [
              const Icon(Icons.wifi, color: Colors.red),
              const SizedBox(width: 8),
              Text(
                "$oldData Go",
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "$newData Go",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // YouTube info
          const Row(
            children: [
              Icon(Icons.cancel_outlined, color: Colors.red, size: 16),
              SizedBox(width: 6),
              Flexible(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'illimité ',
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          text: 'YouTube',
                          style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(),

          // Footer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Valable $duration",
                style: const TextStyle(fontSize: 14),
              ),
              Text(
                "$price DA",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: 18,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Acheter Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text("Acheter", style: TextStyle(fontSize: 16,color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
