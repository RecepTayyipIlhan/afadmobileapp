import 'package:timeago/timeago.dart' as timeago;

class TrMessages extends timeago.LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'şimdi';
  @override
  String aboutAMinute(int minutes) => '$minutes dakika';
  @override
  String minutes(int minutes) => '$minutes d';
  @override
  String aboutAnHour(int minutes) => '~1s';
  @override
  String hours(int hours) => '${hours}s';
  @override
  String aDay(int hours) => '~1g';
  @override
  String days(int days) => '${days}g';
  @override
  String aboutAMonth(int days) => '~1ay';
  @override
  String months(int months) => '${months}ay';
  @override
  String aboutAYear(int year) => '~1yıl';
  @override
  String years(int years) => '${years}yıl';
  @override
  String wordSeparator() => ' ';
}
