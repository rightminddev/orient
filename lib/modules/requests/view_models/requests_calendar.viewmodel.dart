import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class RequestsCalendarViewModel extends ChangeNotifier {
  CalendarView? calendarView = CalendarView.schedule;
  final List<Map<String, dynamic>> calendarViews = [
    // day view
    {'name': 'Day', 'value': CalendarView.day},
    // week view
    {'name': 'Week', 'value': CalendarView.week},
    // month view
    {'name': 'Month', 'value': CalendarView.month},
    // schedule view
    {'name': 'Schedule', 'value': CalendarView.schedule},
    // Timeline day view
    {'name': 'Timeline Day', 'value': CalendarView.timelineDay},
    // Timeline week view
    {'name': 'Timeline Week', 'value': CalendarView.timelineWeek},
    // Timeline month view
    {'name': 'Timeline Month', 'value': CalendarView.timelineMonth},
  ];
  void updateCalendarView(CalendarView view) {
    calendarView = view;
    notifyListeners();
  }

  Color getStatusColor(String? status) {
    switch (status?.toLowerCase().trim()) {
      case 'approved':
        return Colors.green;
      case 'refused':
        return Colors.red;
      case 'canceled':
        return Colors.yellow;
      case 'seen':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
