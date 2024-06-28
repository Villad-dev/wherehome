import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimePickerInsertField extends StatefulWidget {
  final Function(TimeOfDay) onFromTimeSelected;
  final Function(TimeOfDay) onToTimeSelected;
  final Function(int) onIntervalSelected;

  const TimePickerInsertField({
    super.key,
    required this.onFromTimeSelected,
    required this.onToTimeSelected,
    required this.onIntervalSelected,
  });

  @override
  TimePickerFieldState createState() => TimePickerFieldState();
}

class TimePickerFieldState extends State<TimePickerInsertField> {
  final TextEditingController _fromTimeController = TextEditingController();
  final TextEditingController _toTimeController = TextEditingController();
  final TextEditingController _intervalController = TextEditingController();
  TimeOfDay? _selectedFromTime;
  TimeOfDay? _selectedToTime;
  int? _intervalMinutes;

  Future<void> _selectFromTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedFromTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedFromTime) {
      setState(() {
        _selectedFromTime = picked;
        _fromTimeController.text = _selectedFromTime!.format(context);
        widget.onFromTimeSelected(_selectedFromTime!);
      });
    }
  }

  Future<void> _selectToTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedToTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedToTime) {
      setState(() {
        _selectedToTime = picked;
        _toTimeController.text = _selectedToTime!.format(context);
        widget.onToTimeSelected(_selectedToTime!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Flexible(
          flex: 1,
          child: TextField(
            style: const TextStyle(fontSize: 12),
            controller: _fromTimeController,
            readOnly: true,
            onTap: () => _selectFromTime(context),
            decoration: const InputDecoration(
              labelText: 'From',
              suffixIcon: Icon(Icons.access_time),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          flex: 1,
          child: TextField(
            style: const TextStyle(fontSize: 12),
            controller: _toTimeController,
            readOnly: true,
            onTap: () => _selectToTime(context),
            decoration: const InputDecoration(
              labelText: 'To',
              suffixIcon: Icon(Icons.access_time),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          flex: 1,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 150,
            ),
            child: TextField(
              style: const TextStyle(fontSize: 12),
              controller: _intervalController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) {
                setState(() {
                  _intervalMinutes = int.tryParse(value);
                  if (_intervalMinutes != null) {
                    widget.onIntervalSelected(_intervalMinutes!);
                  }
                });
              },
              decoration: const InputDecoration(
                labelText: 'Interval',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
