import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:railbus/ui/components/transaction/transaction_detail.dart';
import 'package:railbus/utils/format_utils.dart';

class TransactionCard extends StatelessWidget {
  final Map<String, dynamic> transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: Icon(
            _getTransactionIcon(transaction["type"]),
            color: Colors.white,
          ),
        ),
        title: Text(
          transaction["type"],
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          DateFormat('MMM dd, yyyy').format(transaction["date"]),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              transaction["type"] == "Share Sale" ? "-${formatNumber(transaction["shares"])}" : "+${formatNumber(transaction["shares"])}",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: _getTypeColor(transaction["type"]),
                  ),
            ),
            Text(
              transaction["status"],
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _getTypeColor(transaction["type"]),
                  ),
            ),
          ],
        ),
        children: [
          TransactionDetail(transaction: transaction),
        ],
      ),
    );
  }

  IconData _getTransactionIcon(String type) {
    switch (type) {
      case 'Share Purchase':
        return Icons.shopping_cart;
      case 'Share Sale':
        return Icons.store;
      default:
        return Icons.history;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'Share Purchase':
        return Colors.green;
      case 'Share Sale':
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}