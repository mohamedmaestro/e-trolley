import 'package:intl/intl.dart';

class TFormatter {
  // Format the date to 'dd-MMM-yyyy'
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date); // Customize the date format as needed
  }

  // Format a double value as currency in the 'en_US' locale with '$' symbol
  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(amount); // Customize the currency locale and symbol as needed
  }

  // Format a phone number assuming a 10-digit US phone number format: (123) 456-7890
  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6)}';
    } else if (phoneNumber.length == 11) {
      return '(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)}-${phoneNumber.substring(7)}';
    }
    // Add more custom phone number formatting logic for different formats if needed.
    return phoneNumber;
  }

  // Format phone number into international format (Not fully tested)
  static String internationalFormatPhoneNumber(String phoneNumber) {
    // Remove any non-digit characters from the phone number
    var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Extract the country code from the digitsOnly
    String countryCode = '+${digitsOnly.substring(0, 2)}';
    digitsOnly = digitsOnly.substring(2);

    // Add the remaining digits with proper formatting
    final formattedNumber = StringBuffer();
    formattedNumber.write('($countryCode) ');

    int i = 0;
    while (i < digitsOnly.length) {
      int groupLength = 2;
      if (i == 0 && countryCode == '+1') {
        groupLength = 3; // In the US, the area code is 3 digits
      }

      int end = i + groupLength;
      formattedNumber.write(digitsOnly.substring(i, end));
      formattedNumber.write(' ');

      if (end < digitsOnly.length) {
        formattedNumber.write('-');
      }

      i = end;
    }

    return formattedNumber.toString().trim();
  }
}

void main() {
  // Test date formatting
  print(TFormatter.formatDate(DateTime(2025, 3, 18))); // Example output: 18-Mar-2025

  // Test currency formatting
  print(TFormatter.formatCurrency(1234.56)); // Example output: $1,234.56

  // Test local phone number formatting (US)
  print(TFormatter.formatPhoneNumber('1234567890')); // Example output: (123) 456-7890

  // Test international phone number formatting (Not fully tested)
  print(TFormatter.internationalFormatPhoneNumber('+911234567890')); // Example output: (+91) 12-34-56-78-90
}
