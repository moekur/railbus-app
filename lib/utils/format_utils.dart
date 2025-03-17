import 'package:intl/intl.dart';

/// Utility function for formatting currency values in AED with accounting format.
String formatCurrency(double value) {
  final NumberFormat f = NumberFormat.currency(
    locale: 'en_US',
    symbol: 'AED ',
    decimalDigits: 2,
    customPattern: '¤#,##0.00;¤(#,##0.00)', // Accounting format with parentheses for negatives
  );
  return f.format(value);
}

/// Utility function for formatting numbers without currency, with commas for thousands.
String formatNumber(double value) {
  final NumberFormat f = NumberFormat(
    '#,##0.00', // Standard number format with 2 decimal places and thousands separator
    'en_US',    // Locale can be changed if needed
  );
  return f.format(value);
}
