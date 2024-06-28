import 'package:easy_localization/easy_localization.dart';

String formatStringPriceWithSpaces(String numberString) {
  numberString = numberString.replaceAll(RegExp(r'\D'), '');
  int number = int.parse(numberString);
  final formatter = NumberFormat('#,###');
  String formatted = formatter.format(number);

  return formatted.replaceAll(',', ' ');
}

String formatDoublePriceWithSpaces(double number) {
  final formatter = NumberFormat('#,##0.00', 'en_US');
  String formatted = formatter.format(number);
  return formatted.replaceAll(',', ' ');
}
