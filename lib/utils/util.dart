import 'dart:ui';

import 'package:intl/intl.dart';

import '../models/dtos/schedule.dart';

class Util{


 static  Map<TaskStatus, int> mappedColors = {
    TaskStatus.skipped:0xFFD9D9D9,
    TaskStatus.finished:0xFF75A9A1,
    TaskStatus.missed:0xFFCE6C57,
    TaskStatus.pending:0xFF75A9A0,
    TaskStatus.rescheduled:0xFF578FCE,

  };


  static int getStatusColor(TaskStatus status) =>    mappedColors[status] ?? 0xFF75A9A0;




  static String getMonthYearFormatted(DateTime date) {
    String month = DateFormat.MMMM().format(date); // e.g., "May"
    String year = date.year.toString();            // e.g., "2025"
    return '$month | $year';
  }


  static String  getDayWithSuffix(DateTime date) {
    int day = date.day;

    // Special case for 11th, 12th, 13th
    if (day >= 11 && day <= 13) {
      return '${day}th';
    }

    switch (day % 10) {
      case 1:
        return '${day}st';
      case 2:
        return '${day}nd';
      case 3:
        return '${day}rd';
      default:
        return '${day}th';
    }
  }



 static String formatSmartRange(DateTime from, DateTime to) {
   final sameDay = from.year == to.year &&
       from.month == to.month &&
       from.day == to.day;

   final sameMonth = from.year == to.year && from.month == to.month;
   final sameYear = from.year == to.year;

   final timeFormat = DateFormat.jm(); // "11:00 AM"
   final dateFormat = DateFormat('MMM d'); // "Jan 11"
   final monthFormat = DateFormat('MMM'); // "Jan"
   final yearFormat = DateFormat('y'); // "2024"

   final fromTime = timeFormat.format(from);
   final toTime = timeFormat.format(to);

   if (sameDay) {
     return '$fromTime - $toTime';
   } else if (sameMonth) {
     return '${dateFormat.format(from)}, $fromTime - '
         '${dateFormat.format(to)}, $toTime';
   } else if (sameYear && from.month != to.month) {
     return '${monthFormat.format(from)} - ${monthFormat.format(to)}, '
         '$fromTime - $toTime';
   } else {
     return '${yearFormat.format(from)} - ${yearFormat.format(to)}, '
         '$fromTime - $toTime';
   }
 }


}