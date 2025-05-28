import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DjeezyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final List<Widget>? actions;

  const DjeezyAppBar({
    super.key,
    this.showBackButton = false,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Djezzy eSIM',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
            )
          : null,
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 212, 31, 31),
      elevation: 0,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
