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
  TimePickerState createState() => TimePickerState();
}

class TimePickerState extends State<TimePicker> {
  DateTime _selectedTime = DateTime.now();

  List<DateTime> _generateHours() {
    List<DateTime> hours = [];
    DateTime currentHour = DateTime(
      widget.from.year,
      widget.from.month,
      widget.from.day,
      widget.from.hour,
    );
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Available hours',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _generateHours().map((hour) {
                return GestureDetector(
                  onTap: () {
                    _onTimeSelected(hour);
                    Navigator.of(context).pop(hour);
                  },
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
          ],
        ),
      ),
    );
  }
}
