import 'package:flutter/material.dart';
import 'package:yoga_frontend/constants/values.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';

///The [SlotButton] is a custom button that represents each slot
///Used in the SlotRadioButtons widget
class SlotButton extends StatelessWidget {
  const SlotButton(this.slot,
      {required this.onChanged,
      required this.slotCount,
      this.selected = false,
      super.key});
  final int slot, slotCount;
  final bool selected;
  final Function()? onChanged;

  ///Returns an indication color, based on the number of slots available
  Color getColor(int slots) {
    if (slots > 49) {
      return Colors.red[900]!;
    } else if (slots > 40) {
      return Colors.red;
    } else if (slots > 30) {
      return Colors.orange;
    } else if (slots > 20) {
      return Colors.yellow;
    } else if (slots > 10) {
      return const Color.fromARGB(255, 150, 220, 11);
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.buttonColor,
      onTap: onChanged,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: selected ? AppColors.buttonColor : Colors.grey,
              width: selected ? 4 : 2),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(slotsTime[slot] ?? "",
                style: selected
                    ? AppTextStyles.radioTextSelected
                    : AppTextStyles.radioText),
            if (slotCount > -1)
              Container(
                //This is the circle that indicates the slot availablility
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: getColor(slotCount)),
              )
          ],
        ),
      ),
    );
  }
}
