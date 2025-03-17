import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildStepElements(context),
      ),
    );
  }

  List<Widget> _buildStepElements(BuildContext context) {
    final List<Widget> elements = [];

    for (int i = 0; i < totalSteps; i++) {
      final step = i + 1;
      
      // Add step indicator
      elements.add(
        Column(
          children: [
            _buildStepIndicator(context, step),
            const SizedBox(height: 4),
            SizedBox(
              width: 60,
              child: Text(
                _getStepLabel(step),
                style: TextStyle(
                  color: currentStep >= step ? Colors.white : Colors.white70,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );

      // Add connector line if not the last step
      if (step < totalSteps) {
        elements.add(
          Column(
            children: [
              _buildStepConnector(context, step),
              const SizedBox(height: 4 + 12), // Match height with indicator + text
            ],
          ),
        );
      }
    }

    return elements;
  }

  Widget _buildStepIndicator(BuildContext context, int step) {
    final isActive = currentStep >= step;
    return CircleAvatar(
      radius: 16,
      backgroundColor: isActive ? Theme.of(context).colorScheme.secondary : Colors.grey,
      child: Text(
        '$step',
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildStepConnector(BuildContext context, int step) {
    final isActive = currentStep > step;
    return Container(
      width: 40,
      height: 2,
      color: isActive ? Theme.of(context).colorScheme.secondary : Colors.white54,
    );
  }

  String _getStepLabel(int step) {
    switch (step) {
      case 1:
        return 'Email';
      case 2:
        return 'Code';
      case 3:
        return 'Password';
      default:
        return '';
    }
  }
}