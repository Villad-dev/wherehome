import 'package:flutter/material.dart';

class CalendarPickerField extends StatefulWidget {
  const CalendarPickerField({
    super.key,
    required this.from,
    required this.to,
    required this.interval,
    required this.onDateSelected,
  });

  final DateTime from;
  final DateTime to;
  final int interval;
  final void Function(DateTime) onDateSelected;

  @override
  CalendarPickerFieldState createState() => CalendarPickerFieldState();
}

class CalendarPickerFieldState extends State<CalendarPickerField> {
  TextEditingController dateController = TextEditingController();

  Future<void> _selectTime(BuildContext context) async {
    DateTime initialDate = DateTime.now();

    if (dateController.text.isNotEmpty) {
      List<String> dateParts = dateController.text.split('-');
      if (dateParts.length == 3) {
        int day = int.tryParse(dateParts[0]) ?? DateTime.now().day;
        int month = int.tryParse(dateParts[1]) ?? DateTime.now().month;
        int year = int.tryParse(dateParts[2]) ?? DateTime.now().year;

        initialDate = DateTime(year, month, day);
      }
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: widget.from,
      lastDate: widget.to,
    );

    if (picked != null) {
      setState(() {
        dateController.text = '${picked.day}-${picked.month}-${picked.year}';
        widget.onDateSelected(picked); // Call the onDateSelected function here
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: dateController.text),
      readOnly: true,
      onTap: () async {
        await _selectTime(context);
      },
      decoration: const InputDecoration(
        labelText: 'Select Date',
        suffixIcon: Icon(Icons.calendar_month_rounded),
      ),
    );
  }
}
