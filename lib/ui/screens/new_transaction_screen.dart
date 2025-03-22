import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:railbus/utils/format_utils.dart';

class NewTransactionScreen extends StatefulWidget {
  const NewTransactionScreen({super.key});

  @override
  State<NewTransactionScreen> createState() => _NewTransactionScreenState();
}

class _NewTransactionScreenState extends State<NewTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  String _transactionType = 'Share Purchase';
  double _shares = 0.0;
  double _amount = 0.0;
  String _shareType = 'Ordinary';
  String _status = 'Pending';
  String _counterParty = '';

  // List of registered app investors
  static const List<String> _registeredInvestors = [
    'Amir Ali',
    'Jasmine Saeed',
    'Mahmoud Hassan',
    'Amina Khan',
    'Omar Patel',
    'Safia Ahmed',
    'Rayan Malik',
    'Layla Rashid',
    'Khalid Abdullah',
    'Nadia Siddiqui',
    'John Doe',
    'Jane Smith',
    'Michael Brown',
    'Emily Davis',
    'William Johnson',
    'Sarah Wilson',
    'David Lee',
    'Laura Adams',
    'Robert Taylor',
    'Emma Clark',
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Create new transaction
      final newTransaction = {
        "date": DateTime.now(),
        "type": _transactionType,
        "amount": _amount,
        "status": _status,
        "shares": _shares,
        "shareType": _shareType,
        "pricePerShare": _amount / _shares,
        "counterParty": _counterParty,
      };

      // Return the new transaction to the caller
      Navigator.pop(context, newTransaction);
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: primaryColor, 
      appBar: AppBar(
        title: const Text('New Transaction'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0, 
      ),
      body: Column(
        children: [
          SafeArea(
            child: Container(
              height: 20,
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    // Transaction Details Section
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Transaction Details',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Transaction Type
                            DropdownButtonFormField<String>(
                              value: _transactionType,
                              decoration: const InputDecoration(
                                labelText: 'Transaction Type',
                                border: OutlineInputBorder(),
                              ),
                              items: const [
                                DropdownMenuItem(value: 'Share Purchase', child: Text('Share Purchase')),
                                DropdownMenuItem(value: 'Share Sale', child: Text('Share Sale')),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _transactionType = value!;
                                });
                              },
                              validator: (value) => value == null ? 'Please select a transaction type' : null,
                            ),
                            const SizedBox(height: 12),
                            // Number of Shares
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Number of Shares',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              onSaved: (value) => _shares = double.tryParse(value ?? '') ?? 0.0,
                              validator: (value) {
                                if (value == null || value.isEmpty) return 'Please enter number of shares';
                                final shares = double.tryParse(value);
                                if (shares == null || shares <= 0) return 'Shares must be a positive number';
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),
                            // Amount
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Share Price (AED)',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              onSaved: (value) => _amount = double.tryParse(value ?? '') ?? 0.0,
                              validator: (value) {
                                if (value == null || value.isEmpty) return 'Please enter amount';
                                final amount = double.tryParse(value);
                                if (amount == null || amount <= 0) return 'Amount must be a positive number';
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),
                            // Share Type
                            DropdownButtonFormField<String>(
                              value: _shareType,
                              decoration: const InputDecoration(
                                labelText: 'Share Type',
                                border: OutlineInputBorder(),
                              ),
                              items: const [
                                DropdownMenuItem(value: 'Ordinary', child: Text('Ordinary')),
                                DropdownMenuItem(value: 'Preference', child: Text('Preference')),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _shareType = value!;
                                });
                              },
                              validator: (value) => value == null ? 'Please select a share type' : null,
                            ),
                            const SizedBox(height: 12),
                            // Counter Party (Autocomplete)
                            Autocomplete<String>(
                              optionsBuilder: (TextEditingValue textEditingValue) {
                                final input = textEditingValue.text.trim();
                                // Show suggestions only after 3 letters
                                if (input.length < 3) {
                                  return const Iterable<String>.empty();
                                }
                                return _registeredInvestors.where((String investor) {
                                  return investor.toLowerCase().contains(input.toLowerCase());
                                });
                              },
                              onSelected: (String selection) {
                                setState(() {
                                  _counterParty = selection;
                                });
                              },
                              fieldViewBuilder: (BuildContext context,
                                  TextEditingController fieldTextEditingController,
                                  FocusNode fieldFocusNode,
                                  VoidCallback onFieldSubmitted) {
                                return TextFormField(
                                  controller: fieldTextEditingController,
                                  focusNode: fieldFocusNode,
                                  decoration: const InputDecoration(
                                    labelText: 'Counter Party',
                                    border: OutlineInputBorder(),
                                  ),
                                  onSaved: (value) => _counterParty = value ?? '',
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Please select a counter party';
                                    }
                                    if (!_registeredInvestors.contains(value.trim())) {
                                      return 'Counter party must be a registered investor';
                                    }
                                    return null;
                                  },
                                );
                              },
                              optionsViewBuilder: (BuildContext context,
                                  AutocompleteOnSelected<String> onSelected,
                                  Iterable<String> options) {
                                return Align(
                                  alignment: Alignment.topLeft,
                                  child: Material(
                                    elevation: 4.0,
                                    child: Container(
                                      constraints: const BoxConstraints(maxHeight: 200),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: options.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          final String option = options.elementAt(index);
                                          return GestureDetector(
                                            onTap: () => onSelected(option),
                                            child: ListTile(
                                              title: Text(option),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 12),
                            // Status
                            DropdownButtonFormField<String>(
                              value: _status,
                              decoration: const InputDecoration(
                                labelText: 'Status',
                                border: OutlineInputBorder(),
                              ),
                              items: const [
                                DropdownMenuItem(value: 'Pending', child: Text('Pending')),
                                DropdownMenuItem(value: 'Approved', child: Text('Approved')),
                                DropdownMenuItem(value: 'Declined', child: Text('Declined')),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _status = value!;
                                });
                              },
                              validator: (value) => value == null ? 'Please select a status' : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Submit Button
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Submit Transaction',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}