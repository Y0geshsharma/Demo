import 'package:intl/intl.dart';

String convertMicrosecondsToDateTime(String dateString) {
  final DateFormat formatter = DateFormat.E().add_d().add_LLL().add_Hm();
  final DateFormat parser = DateFormat('M/dd/yyyy HH:mm:ss');
  final String _formattedDateString =
      formatter.format(parser.parse(dateString));

  return _formattedDateString;
}
