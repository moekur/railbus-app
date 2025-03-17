import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatsComponent extends StatelessWidget {
  final String title;
  final double totalValue;
  final double percentageIncrease;
  final double amountIncrease;

  const StatsComponent({
    required this.title,
    required this.totalValue,
    required this.percentageIncrease,
    required this.amountIncrease,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize NumberFormat for accounting format
    final NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'en_US', // Comma as thousands separator
      symbol: 'AED ', // Currency symbol
      decimalDigits: 2, // Fixed 2 decimal places
      customPattern: '¤#,##0.00;(¤#,##0.00)', // Parentheses for negatives
    );

    final String formattedTotalValue = currencyFormat.format(totalValue);
    final String formattedAmountIncrease = currencyFormat.format(amountIncrease);

    // Format percentage with 1 decimal place
    final NumberFormat percentageFormat = NumberFormat('#,##0.0', 'en_US');
    final String formattedPercentageIncrease = percentageFormat.format(percentageIncrease);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: Colors.white70),
        ),
        const SizedBox(height: 4),
        Text(
          formattedTotalValue,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Row(
          children: [
            Text(
              formattedAmountIncrease,
              style: TextStyle(
                fontSize: 12,
                color: amountIncrease >= 0 ? Colors.green : Colors.red, // Red for negative
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '(+${formattedPercentageIncrease}%)',
              style: const TextStyle(fontSize: 12, color: Colors.green),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ],
    );
  }
}