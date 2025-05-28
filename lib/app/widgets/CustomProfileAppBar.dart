import 'package:flutter/material.dart';

class CustomProfileAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String name;
  final String userId;
  final String imageUrl;
  final VoidCallback? onSettingsTap;

  const CustomProfileAppBar({
    super.key,
    required this.name,
    required this.userId,
    required this.imageUrl,
    this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF9C27B0), Color(0xFF7B1FA2)], // Purple gradient
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: onSettingsTap,
              child: const Icon(Icons.settings, color: Colors.white, size: 28),
            ),
          ),
          const Positioned(
            top: 40,
            left: 20,
            child: Text(
              '9:41',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                const SizedBox(width: 20),
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 42,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "ID: $userId",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(80);
}
