import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarDialog extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime initialFocusedDay;
  final DateTime initialSelectedDay;
  final void Function(DateTime, DateTime) onDaySelected;
  final Map<DateTime, List<String>> events;

  const TableCalendarDialog({
    super.key,
    required this.firstDate,
    required this.lastDate,
    required this.initialFocusedDay,
    required this.initialSelectedDay,
    required this.onDaySelected,
    required this.events,
  });

  @override
  TableCalendarDialogState createState() => TableCalendarDialogState();
}

class TableCalendarDialogState extends State<TableCalendarDialog> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late List<String> eventList;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.initialFocusedDay;
    _selectedDay = widget.initialSelectedDay;
    eventList = widget.events[_selectedDay] ?? [];
  }

  List<String> _getEventsForDay(DateTime day) {
    return widget.events.entries
        .where((entry) => isSameDay(entry.key, day))
        .map((entry) => entry.value)
        .expand((element) => element)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Select a Date"),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close_rounded),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 420,
            width: double.maxFinite,
            child: TableCalendar(
              startingDayOfWeek: StartingDayOfWeek.monday,
              firstDay: widget.firstDate,
              lastDay: widget.lastDate,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedD, focusedD) {
                setState(() {
                  _selectedDay = selectedD;
                  _focusedDay = focusedD;
                  eventList = _getEventsForDay(selectedD);
                });
                widget.onDaySelected(selectedD, focusedD);
              },
              eventLoader: (day) {
                return _getEventsForDay(day);
              },
              calendarStyle: const CalendarStyle(
                markersMaxCount: 3,
                markerDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (eventList.isNotEmpty) ...[
            const Text('Events:'),
            for (var event in eventList)
              ListTile(
                title: Text(event),
              ),
          ] else
            const Text('No events for the selected date.'),
        ],
      ),
    );
  }
}
