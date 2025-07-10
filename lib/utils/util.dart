import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../models/dtos/schedule.dart';

class Util{
 static  String  findPercentage(double? a, double? b)=>
       (a == null || b == null) ? "0":
       ((a/b) * 100).toStringAsFixed(1);


static  String formatCount(double ? number) {
    if (number == null) return '0';
    if (number < 1000) return number.toString();

    final units = [
      {'value': 1e12, 'suffix': 'T'},
      {'value': 1e9,  'suffix': 'B'},
      {'value': 1e6,  'suffix': 'M'},
      {'value': 1e3,  'suffix': 'K'},
    ];

    for (var unit in units) {
      final unitValue = unit['value'] as num;
      final suffix = unit['suffix'] as String;

      if (number >= unitValue) {
        double result = number / unitValue;
        return result
            .toStringAsFixed(result < 10 ? 1 : 0)
            .replaceAll(RegExp(r'\.0$'), '') + suffix;
      }
    }

    return number.toString();
  }

  static double scaleFont(BuildContext context, double baseFontSize) {
    final double screenWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 360.0;

    // Linear scale based on screen width
    final double scale = screenWidth / baseWidth;

    // Dampens the scale so fonts don’t grow too fast
    final double dampenedScale = 1 + (scale - 1) * 0.5;

    // Clamp to keep font sizes in a sensible range
    return (baseFontSize * dampenedScale).clamp(12.0, 24.0);
  }

  /// Scales a design pixel value (e.g., 13) based on a 360px-wide design
  static double scaleWidthFromDesign(BuildContext context, double designPixels) {
    final screenWidth = MediaQuery.of(context).size.width;
    return (screenWidth / 360) * designPixels;
  }


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
   final dateFormat = DateFormat('d'); // "Jan 11"
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
     return '${monthFormat.format(from)} - ${monthFormat.format(to)}, ';
         // '$fromTime - $toTime';
   } else {
     return '${yearFormat.format(from)} - ${yearFormat.format(to)} ';
         // '$fromTime - $toTime';
   }
 }


}