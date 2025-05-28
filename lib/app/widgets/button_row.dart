import 'package:firstgetxapp/app/modules/home/controllers/button_row_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonRow extends StatelessWidget {
  final List<String> labels;

  ButtonRow({super.key, required this.labels});

  final ButtonRowController controller = Get.put(ButtonRowController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(labels.length, (index) {
            final isSelected = controller.selectedIndex.value == index;

            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isSelected ? Colors.red : Colors.grey[300],
                foregroundColor: isSelected ? Colors.white : Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              ),
              onPressed: () => controller.selectButton(index),
              child: Text(labels[index]),
            );
          }),
        ));
  }
}
