import 'package:flutter/material.dart';

class TimeSelectorComponent extends StatelessWidget {
  final String selectedPeriod;
  final Function(String) onPeriodSelected;

  const TimeSelectorComponent({
    required this.selectedPeriod,
    required this.onPeriodSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: ['Day', 'Week', 'Month', 'All'].map((period) {
        return TextButton(
          onPressed: () => onPeriodSelected(period.toLowerCase()),
          child: Text(
            period,
            style: TextStyle(
              color: selectedPeriod == period.toLowerCase() ? Colors.white : Colors.white70,
            ),
          ),
        );
      }).toList(),
    );
  }
}