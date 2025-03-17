import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart'; // Included for potential future chart integration
import 'dart:math';
import 'package:railbus/ui/components/transaction/transaction_header.dart';
import 'package:railbus/ui/components/transaction/transaction_list_section.dart';
import 'package:railbus/ui/screens/new_transaction_screen.dart';
import 'package:railbus/utils/format_utils.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  String selectedPeriod = 'month';

  // Simulated transaction data with dates in 2024 to avoid current year (2025)
  final List<Map<String, dynamic>> transactions = List.generate(
    20,
    (index) {
      final type = ["Share Purchase", "Share Sale"][Random().nextInt(2)];
      final shares = (Random().nextDouble() * 990) + 10; // 10 to 1000 shares as a double
      final amount = Random().nextDouble() * 5000 + 1000; // Random amount between 1000 and 6000
      final shareType = ["Ordinary", "Preference"][Random().nextInt(2)];
      return {
        "date": DateTime(2024, 12, 31).subtract(Duration(days: index * 10)), // Dates in 2024
        "type": type,
        "amount": amount,
        "status": ["Approved", "Pending", "Declined"][Random().nextInt(3)],
        "shares": shares,
        "shareType": shareType,
        "counterParty": "John Doe",
      };
    },
  ).map((transaction) {
    // Calculate pricePerShare since shares and amount are always valid
    final amount = transaction["amount"] as double;
    final shares = transaction["shares"] as double;
    transaction["pricePerShare"] = amount / shares;
    return transaction;
  }).toList();

  void _onPeriodSelected(String period) {
    setState(() {
      selectedPeriod = period;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _onNewTransactionRequest() async {
    // Navigate to NewTransactionScreen and wait for result
    final newTransaction = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewTransactionScreen()),
    );

    // If a new transaction was returned, add it to the list
    if (newTransaction != null) {
      setState(() {
        transactions.insert(0, newTransaction); // Add to top
      });
      _showSnackBar('Transaction added successfully!');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter transactions based on selected period
    List<Map<String, dynamic>> filteredTransactions = transactions.where((transaction) {
      final transactionDate = transaction["date"] as DateTime;
      final now = DateTime.now();
      switch (selectedPeriod) {
        case 'day':
          return now.difference(transactionDate).inDays == 0;
        case 'week':
          return now.difference(transactionDate).inDays <= 7;
        case 'month':
          return now.difference(transactionDate).inDays <= 30;
        case 'year':
          return now.difference(transactionDate).inDays <= 365;
        default:
          return true;
      }
    }).toList();

    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        child: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TransactionHeader(
                selectedPeriod: selectedPeriod,
                onPeriodSelected: _onPeriodSelected,
              ),
              TransactionListSection(
                filteredTransactions: filteredTransactions,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onNewTransactionRequest,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}