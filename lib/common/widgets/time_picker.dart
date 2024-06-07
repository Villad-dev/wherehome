import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({
    super.key,
    required this.from,
    required this.to,
    required this.interval,
  });

  final DateTime from;
  final DateTime to;
  final int interval;

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  DateTime _selectedTime = DateTime.now();

  List<DateTime> _generateHours() {
    List<DateTime> hours = [];
    DateTime currentHour = DateTime(widget.from.hour);
    while (currentHour.isBefore(widget.to)) {
      hours.add(currentHour);
      currentHour = currentHour.add(Duration(minutes: widget.interval));
    }
    return hours;
  }

  void _onTimeSelected(DateTime time) {
    setState(() {
      _selectedTime = time;
    });
  }

  bool isSameTime(DateTime time) {
    return time.hour == _selectedTime.hour &&
        time.minute == _selectedTime.minute;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _generateHours().map((hour) {
            return GestureDetector(
              onTap: () => _onTimeSelected(hour),
              child: Card(
                elevation: 3,
                color: isSameTime(hour) ? Colors.blueAccent : null,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${hour.hour}:${hour.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
