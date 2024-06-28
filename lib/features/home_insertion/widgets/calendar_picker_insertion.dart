import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CalendarPickerInputField extends StatefulWidget {
  final DateTime availableFrom;
  final DateTime availableTo;
  final Function(DateTimeRange) onDateSelected;

  const CalendarPickerInputField({
    super.key,
    required this.availableFrom,
    required this.availableTo,
    required this.onDateSelected,
  });

  @override
  CalendarPickerFieldState createState() => CalendarPickerFieldState();
}

class CalendarPickerFieldState extends State<CalendarPickerInputField> {
  TextEditingController dateController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: widget.availableFrom,
      lastDate: widget.availableTo,
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
        dateController.text =
            "${formatter.format(_startDate!.toLocal())} - ${formatter.format(_endDate!.toLocal())}";
        widget.onDateSelected(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: dateController,
      readOnly: true,
      onTap: () => _selectDate(context),
      decoration: const InputDecoration(
        labelText: 'Select Date',
        suffixIcon: Icon(Icons.calendar_today),
      ),
    );
  }
}
