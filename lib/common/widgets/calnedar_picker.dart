import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CalendarPicker extends StatefulWidget {
  const CalendarPicker({super.key, required this.onDateSelected});

  final ValueChanged<DateTime> onDateSelected;

  @override
  CalendarPickerState createState() => CalendarPickerState();
}

class CalendarPickerState extends State<CalendarPicker> {
  DateTime _selectedDate = DateTime.now();
  int _selectedMonth = DateTime.now().month;
  int _selectedYear = DateTime.now().year;

  void _onDaySelected(DateTime date) {
    setState(() {
      _selectedDate = date;
      widget.onDateSelected(date);
    });
  }

  void _onMonthChanged() {
    setState(() {});
  }

  Widget _buildMonthName() {
    final month =
        DateFormat.MMMM().format(DateTime(_selectedYear, _selectedMonth));
    final year = DateFormat.y().format(DateTime(_selectedYear));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              setState(() {
                // _selectedMonth = _selectedMonth - 1;
              });
            },
            icon: const Icon(Icons.arrow_back_rounded)),
        Row(
          children: [
            TextButton(
              onPressed: () {
                // TODO: Handle month tap
              },
              child: Text(
                month,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: Handle year tap
              },
              child: Text(
                year,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        IconButton(
            onPressed: () {
              setState(() {
                // _selectedMonth = _selectedMonth + 1;
              });
            },
            icon: const Icon(Icons.arrow_forward_rounded))
      ],
    );
  }

  List<Widget> _buildDaysOfWeek() {
    final daysOfWeek = [
      'monday_name',
      'tuesday_name',
      'wednesday_name',
      'thursday_name',
      'friday_name',
      'saturday_name',
      'sunday_name',
    ];
    return daysOfWeek
        .map((day) => Expanded(
              child: Center(
                child: Text(
                  day,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ).tr(),
              ),
            ))
        .toList();
  }

  List<Widget> _buildCalendarDays() {
    final firstDayOfMonth = DateTime(_selectedYear, _selectedMonth, 1);
    final lastDayOfMonth = DateTime(_selectedYear, _selectedMonth + 1, 0);

    // Find out what day of the week the first day of the month is
    int startPadding = firstDayOfMonth.weekday % 7;

    List<Widget> dayWidgets = [];
    if (startPadding > 0) {
      final lastDayOfPrevMonth = DateTime(_selectedYear, _selectedMonth, 0);
      final daysFromPrevMonth = List.generate(startPadding, (index) {
        final date = lastDayOfPrevMonth
            .subtract(Duration(days: startPadding - index - 1));
        return Expanded(
          child: Container(
            margin: const EdgeInsets.all(2.0),
            child: Center(
              child: Text(
                '${date.day}',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
        );
      });
      dayWidgets.addAll(daysFromPrevMonth);
    }

    // Add the days of the current month
    int totalDays = lastDayOfMonth.day;
    for (int i = 1; i <= totalDays; i++) {
      final currentDate = DateTime(_selectedYear, _selectedMonth, i);
      dayWidgets.add(
        Expanded(
          child: GestureDetector(
            onTap: () => _onDaySelected(currentDate),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSameDay(_selectedDate, currentDate)
                    ? Colors.blueAccent
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$i',
                style: TextStyle(
                  color: isSameDay(_selectedDate, currentDate)
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Add the days from the next month to end the grid correctly
    int endPadding = (7 - (totalDays + startPadding) % 7) % 7;
    if (endPadding > 0) {
      final firstDayOfNextMonth =
          DateTime(_selectedYear, _selectedMonth + 1, 1);
      final daysFromNextMonth = List.generate(endPadding, (index) {
        final date = firstDayOfNextMonth.add(Duration(days: index));
        return Expanded(
          child: Container(
            margin: const EdgeInsets.all(2.0),
            child: Center(
              child: Text(
                '${date.day}',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
        );
      });
      dayWidgets.addAll(daysFromNextMonth);
    }

    return dayWidgets;
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor,
            offset: Offset(1, 1),
            spreadRadius: 2,
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMonthName(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _buildDaysOfWeek(),
          ),
          const SizedBox(height: 8),
          Column(
            children: List.generate((42 / 7).ceil(), (index) {
              int startIndex = index * 7;
              int endIndex = startIndex + 7;
              return Row(
                children: _buildCalendarDays().sublist(startIndex, endIndex),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class MonthPicker extends StatefulWidget {
  const MonthPicker({super.key});

  @override
  State<MonthPicker> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
