import 'package:intl/intl.dart';

extension DateToStringFormatExtension on DateTime {
  String get toyyyyMMdd => DateFormat('yyyy-MM-dd').format(this.toLocal());

  String get toEEEMMMdd => DateFormat("EEE, MMM dd").format(this.toLocal());

  String get toEEEMMMddhhmma => DateFormat("EEE, MMM dd | h:mm a").format(this.toLocal());

  String get toMMMDddyyyyhhmma =>
      DateFormat("MMM dd, yyyy - h:mm a").format(this.toLocal());

  String get todMMM => DateFormat("- d MMM").format(this.toLocal());

  String get toMMMdyyyy => DateFormat("MMMM d, yyyy").format(this.toLocal());

  String get toMMMyyyy => DateFormat("MMMM, yyyy").format(this.toLocal());
}

extension StringToDateExtension on String {
  DateTime get toyyyyMMddParse => DateFormat("yyyy-MM-dd").parse(this);

  DateTime get toyyyyMMParse => DateFormat("yyyy-MM").parse(this);

  DateTime get toyyyyMMddhhmmssParse =>
      DateFormat("yyyy-MM-dd hh:mm:ss").parse(this);
}

extension DateTimeExt on DateTime {
  int get daysSince => DateTime.now().difference(this).inDays;
}
