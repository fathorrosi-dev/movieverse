import 'package:intl/intl.dart';

String formatDate(String inputDate) {
  final date = DateFormat("yyyy-MM-dd").parse(inputDate);
  final formattedDate = DateFormat("MMMM d, yyyy").format(date);
  return formattedDate;
}
