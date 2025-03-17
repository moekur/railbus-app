import 'package:flutter/material.dart';
import 'package:railbus/ui/components/transaction/transaction_card.dart';

class TransactionListSection extends StatelessWidget {
  final List<Map<String, dynamic>> filteredTransactions;

  const TransactionListSection({
    super.key,
    required this.filteredTransactions,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (filteredTransactions.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(child: Text('No transactions found.')),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredTransactions.length,
                    itemBuilder: (context, index) {
                      final transaction = filteredTransactions[index];
                      return TransactionCard(transaction: transaction);
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}