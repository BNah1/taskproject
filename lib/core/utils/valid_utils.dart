import 'package:intl/intl.dart';

String formatDate(DateTime date){
  // return date.toString();
  return DateFormat('EEE d MMMM yyyy - hh:mm a').format(date);
}

String formatDateHour(DateTime date) {
  // return date.toString();
  return DateFormat('hh:mm a').format(date);
}

String formatTime(DateTime time) {
  return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}

String formatDateDay(DateTime date) {
  // return date.toString();
  return DateFormat('dd').format(date);
}
String formatDateWeekDay(DateTime date) {
  // return date.toString();
  return DateFormat('E').format(date);

}

String formatDateCalender(DateTime date) {
  // return date.toString();
  return DateFormat('EEE d MMMM yyyy').format(date);
}
