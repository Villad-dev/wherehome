import 'package:flutter/material.dart';
import 'package:wherehome/common/widgets/time_picker.dart';

class TimePickerField extends StatefulWidget {
  const TimePickerField({
    super.key,
    required this.from,
    required this.to,
    required this.interval,
    required this.onTimePicked,
  });

  final DateTime from;
  final DateTime to;
  final int interval;
  final Function(DateTime) onTimePicked;

  @override
  TimePickerFieldState createState() => TimePickerFieldState();
}

class TimePickerFieldState extends State<TimePickerField> {
  final TextEditingController _timeController = TextEditingController();

  Future<void> _selectTime(BuildContext context) async {
    final DateTime now = DateTime.now();
    final from = DateTime(
        now.year, now.month, now.day, widget.from.hour, widget.from.minute);
    final to = DateTime(
        now.year, now.month, now.day, widget.to.hour, widget.to.minute);
    final DateTime picked = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: TimePicker(
            from: from,
            to: to,
            interval: widget.interval,
          ),
        );
      },
    );

    widget.onTimePicked(picked);
    setState(() {
      _timeController.text =
          '${picked.hour}:${picked.minute.toString().padLeft(2, '0')}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: _timeController.text),
      readOnly: true,
      onTap: () async {
        await _selectTime(context);
      },
      decoration: const InputDecoration(
        labelText: 'Select Time',
        suffixIcon: Icon(Icons.access_time),
      ),
    );
  }
}
