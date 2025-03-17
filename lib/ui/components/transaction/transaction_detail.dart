import 'package:flutter/material.dart';
import 'package:railbus/utils/format_utils.dart';

class TransactionDetail extends StatelessWidget {
  final Map<String, dynamic> transaction;

  const TransactionDetail({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Amount: ${formatCurrency(transaction["amount"])}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 4),
          Text(
            'Price per Share: ${formatCurrency(transaction["pricePerShare"])}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 4),
          Text(
            'Share Type: ${transaction["shareType"]}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 4),
          Text(
            'Counter Party: ${transaction["counterParty"] ?? "N/A"}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}