import 'package:flutter/material.dart';
import 'package:yoga_frontend/constants/text_styles.dart';
import 'package:yoga_frontend/interface/screens/register_form/slot_button.dart';
import 'package:yoga_frontend/services/check_slots.dart';

///The [SlotRadioButtons] is a custom widget that is used to select the slot for the user
///Used in the registration form and the User Dashboard
class SlotRadioButtons extends StatefulWidget {
  final Function(int)? onChanged;
  final int slot;
  const SlotRadioButtons({this.onChanged, this.slot = 1, super.key});

  @override
  State<SlotRadioButtons> createState() => _SlotRadioButtonsState();
}

class _SlotRadioButtonsState extends State<SlotRadioButtons> {
  @override
  void initState() {
    super.initState();
    slot = widget.slot;
  }

  ///Temporarily stores the selected slot
  int slot = 1;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
        future: checkSlots(),
        initialData: const [-1, -1, -1, -1],
        builder: (context, snap) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Select Slot:', style: AppTextStyles.radioTextSelected),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: SlotButton(
                      1,
                      selected: slot == 1,
                      onChanged: () {
                        setState(() {
                          slot = 1;
                        });
                        widget.onChanged?.call(1);
                      },
                      slotCount: snap.hasData ? snap.data![0] : -1,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SlotButton(
                      2,
                      selected: slot == 2,
                      onChanged: () {
                        setState(() {
                          slot = 2;
                        });
                        widget.onChanged?.call(2);
                      },
                      slotCount: snap.hasData ? snap.data![1] : -1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: SlotButton(
                      3,
                      selected: slot == 3,
                      onChanged: () {
                        setState(() {
                          slot = 3;
                        });
                        widget.onChanged?.call(3);
                      },
                      slotCount: snap.hasData ? snap.data![2] : -1,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SlotButton(
                      4,
                      selected: slot == 4,
                      onChanged: () {
                        setState(() {
                          slot = 4;
                        });
                        widget.onChanged?.call(4);
                      },
                      slotCount: snap.hasData ? snap.data![3] : -1,
                    ),
                  )
                ],
              ),
            ],
          );
        });
  }
}
