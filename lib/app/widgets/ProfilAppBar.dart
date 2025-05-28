import 'package:firstgetxapp/app/modules/infos/views/infos_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String phoneNumber;
  final String pathImage;

  const ProfileAppBar({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.pathImage,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;

    if (pathImage.startsWith('http')) {
      imageProvider = NetworkImage(pathImage);
    } else {
      imageProvider = AssetImage(pathImage);
    }

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.to(InfosView());
            },
            child: CircleAvatar(
              radius: 20,
              backgroundImage: imageProvider,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                phoneNumber,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.red),
            onPressed: () {
              // Action when notification is tapped
            },
          ),
        ],
      ),
    );
  }
}
