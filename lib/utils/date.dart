import 'package:intl/intl.dart';
import 'package:simple_moment/simple_moment.dart';

String fromNow(date) {
  if (date == null || date == '') {
    return '';
  }

  Moment.setLocaleGlobally(new LocalePtBr());
  final Moment rawDate = Moment.parse(date);
  final moment = new Moment.fromDate(rawDate.date);
  return moment.fromNow().replaceAll('em', '');
}

class DateUtil {
  static format(String mode, dynamic date) {
    if (date != null) {
      if (date.runtimeType == DateTime) {
        final dateFormatted = DateFormat(mode).format(date);
        return dateFormatted;
      } else {
        final dateFormatted = DateFormat(mode).format(DateTime.parse(date));
        return dateFormatted;
      }
    }
    return '';
  }
}
