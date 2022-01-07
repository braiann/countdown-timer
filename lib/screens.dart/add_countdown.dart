import 'package:countdown_timer/models/countdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddCountdown extends StatelessWidget {
  const AddCountdown({Key? key, required this.lastID}) : super(key: key);
  final int lastID;

  @override
  Widget build(BuildContext context) {
    String _description = '';
    DateTime _doneAt = DateTime.now();
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: CupertinoActionSheet(
        message: Column(
          children: [
            const Text(
              'Add countdown',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            CupertinoTextField(
              placeholder: 'Title',
              onChanged: (value) {
                _description = value;
              },
            ),
            SizedBox(
              width: double.infinity,
              height: 75,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (value) {
                  SystemSound.play(SystemSoundType.click);
                  HapticFeedback.lightImpact();
                  _doneAt = DateTime(value.year, value.month, value.day,
                      _doneAt.hour, _doneAt.minute);
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 75,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (value) {
                  SystemSound.play(SystemSoundType.click);
                  HapticFeedback.lightImpact();
                  _doneAt = DateTime(_doneAt.year, _doneAt.month, _doneAt.day,
                      value.hour, value.minute);
                },
              ),
            ),
          ],
        ),
        actions: [
          CupertinoButton(
            child: const Text(
              'OK',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.pop(
                context,
                Countdown(
                  id: lastID + 1,
                  doneAt: _doneAt,
                  description: _description,
                ),
              );
            },
          ),
        ],
        cancelButton: CupertinoButton(
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.redAccent),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
