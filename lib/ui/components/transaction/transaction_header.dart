import 'package:flutter/material.dart';
import 'package:railbus/ui/components/dashboard/time_selector_component.dart';

class TransactionHeader extends StatelessWidget {
  final String selectedPeriod;
  final Function(String) onPeriodSelected;

  const TransactionHeader({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction History',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 16),
          TimeSelectorComponent(
            selectedPeriod: selectedPeriod,
            onPeriodSelected: onPeriodSelected,
          ),
        ],
      ),
    );
  }
}