import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final String status;
  final double width;

  final EdgeInsetsGeometry margin;

  // Constructor to accept parameters
  const HomeCard({
    super.key,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.status,
    this.width = double.infinity,
    this.margin = const EdgeInsets.only(top: 20),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      padding: const EdgeInsets.symmetric(
          vertical: 20, horizontal: 20), // Padding inside the container
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(229, 229, 229, 1), // Border color
          width: 2, // Border width
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment
            .start, // Align text to the left inside the column
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text1,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 0),
                ),
                onPressed: () {},
                child: Text(status,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    )),
              )
            ],
          ),
          Text(text2, style: const TextStyle(fontSize: 20)),
          Text(text3, style: const TextStyle(fontSize: 14)),
          Text(text4, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
