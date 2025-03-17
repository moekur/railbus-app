import 'package:flutter/material.dart';

class InvestmentDetailsSection extends StatefulWidget {
  final TextEditingController investmentTypeController;
  final TextEditingController bankNameController;
  final TextEditingController accountNumberController;
  final TextEditingController ibanController;
  final TextEditingController taxIdController;

  const InvestmentDetailsSection({
    super.key,
    required this.investmentTypeController,
    required this.bankNameController,
    required this.accountNumberController,
    required this.ibanController,
    required this.taxIdController,
  });

  @override
  State<InvestmentDetailsSection> createState() => _InvestmentDetailsSectionState();
}

class _InvestmentDetailsSectionState extends State<InvestmentDetailsSection> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Investment Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: widget.investmentTypeController.text,
              decoration: const InputDecoration(
                labelText: 'Investment Type',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.black87),
              ),
              style: const TextStyle(color: Colors.black87),
              items: const [
                DropdownMenuItem(value: 'Individual', child: Text('Individual')),
                DropdownMenuItem(value: 'Corporate', child: Text('Corporate')),
              ],
              onChanged: (value) {
                setState(() {
                  widget.investmentTypeController.text = value!;
                });
              },
              validator: (value) =>
                  value == null || value.isEmpty ? 'Please select an investment type' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: widget.bankNameController,
              decoration: const InputDecoration(
                labelText: 'Bank Name',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.black87),
              ),
              style: const TextStyle(color: Colors.black87),
              validator: (value) =>
                  value == null || value.trim().isEmpty ? 'Please enter your bank name' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: widget.accountNumberController,
              decoration: const InputDecoration(
                labelText: 'Account Number',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.black87),
              ),
              style: const TextStyle(color: Colors.black87),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value == null || value.trim().isEmpty ? 'Please enter your account number' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: widget.ibanController,
              decoration: const InputDecoration(
                labelText: 'IBAN',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.black87),
              ),
              style: const TextStyle(color: Colors.black87),
              validator: (value) =>
                  value == null || value.trim().isEmpty ? 'Please enter your IBAN' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: widget.taxIdController,
              decoration: const InputDecoration(
                labelText: 'Tax ID',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.black87),
              ),
              style: const TextStyle(color: Colors.black87),
              validator: (value) =>
                  value == null || value.trim().isEmpty ? 'Please enter your Tax ID' : null,
            ),
          ],
        ),
      ),
    );
  }
}