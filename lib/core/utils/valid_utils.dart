import 'package:intl/intl.dart';

String formatDate(DateTime date){
  // return date.toString();
  return DateFormat('EEE d MMMM yyyy - hh:mm a').format(date);
}

String formatDateHour(DateTime date) {
  // return date.toString();
  return DateFormat('hh:mm a').format(date);
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
