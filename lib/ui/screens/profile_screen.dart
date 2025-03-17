import 'package:flutter/material.dart';
import 'package:railbus/ui/components/registration/documents_section.dart';
import 'package:railbus/ui/components/registration/investment_details_section.dart';
import 'package:railbus/ui/components/registration/personal_information_section.dart';
import 'package:railbus/ui/components/registration/profile_picture_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Initial profile data
  Map<String, dynamic> userProfile = {
    "name": "John Doe",
    "email": "john.doe@example.com",
    "phone": "+971 50 123 4567",
    "address": "123 Business Street, Dubai, UAE",
    "country": "United Arab Emirates",
    "investmentType": "Individual",
    "bankName": "Emirates NBD",
    "accountNumber": "1234567890",
    "iban": "AE070331234567890123456",
    "taxId": "TAX-123456",
    "idCopyUrl": "https://example.com/john_doe_id.pdf",
    "otherDocumentsUrl": "https://example.com/john_doe_other_docs.pdf",
  };

  // Controllers for editable fields
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _countryController;
  late TextEditingController _bankNameController;
  late TextEditingController _accountNumberController;
  late TextEditingController _ibanController;
  late TextEditingController _taxIdController;

  String _investmentType = "Individual";
  late List<Document> _existingDocuments;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: userProfile["name"]);
    _emailController = TextEditingController(text: userProfile["email"]);
    _phoneController = TextEditingController(text: userProfile["phone"]);
    _addressController = TextEditingController(text: userProfile["address"]);
    _countryController = TextEditingController(text: userProfile["country"]);
    _bankNameController = TextEditingController(text: userProfile["bankName"]);
    _accountNumberController = TextEditingController(text: userProfile["accountNumber"]);
    _ibanController = TextEditingController(text: userProfile["iban"]);
    _taxIdController = TextEditingController(text: userProfile["taxId"]);
    _investmentType = userProfile["investmentType"];

    // Initialize existing documents from userProfile
    _existingDocuments = [];
    if (userProfile["idCopyUrl"] != null) {
      _existingDocuments.add(Document(
        name: 'ID Copy',
        filePath: userProfile["idCopyUrl"],
      ));
    }
    if (userProfile["otherDocumentsUrl"] != null) {
      _existingDocuments.add(Document(
        name: 'Other Documents',
        filePath: userProfile["otherDocumentsUrl"],
      ));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _countryController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _ibanController.dispose();
    _taxIdController.dispose();
    super.dispose();
  }

  void _showMessage(String message, bool isError) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.redAccent : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(10),
      ),
    );
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        userProfile["name"] = _nameController.text;
        userProfile["email"] = _emailController.text;
        userProfile["phone"] = _phoneController.text;
        userProfile["address"] = _addressController.text;
        userProfile["country"] = _countryController.text;
        userProfile["investmentType"] = _investmentType;
        userProfile["bankName"] = _bankNameController.text;
        userProfile["accountNumber"] = _accountNumberController.text;
        userProfile["iban"] = _ibanController.text;
        userProfile["taxId"] = _taxIdController.text;
      });
      _showMessage('Profile updated successfully!', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              ProfilePictureSection(
                name: userProfile["name"],
                onCameraPressed: () {
                  _showMessage('Profile picture upload coming soon!', false);
                },
              ),
              const SizedBox(height: 24),
              PersonalInformationSection(
                nameController: _nameController,
                emailController: _emailController,
                passwordController: null,
                confirmPasswordController: null,
                phoneController: _phoneController,
                addressController: _addressController,
                countryController: _countryController,
                onNameChanged: () => setState(() {
                  userProfile["name"] = _nameController.text;
                }),
                isEditable: true,
              ),
              const SizedBox(height: 24),
              InvestmentDetailsSection(
                investmentTypeController: TextEditingController(text: _investmentType),
                bankNameController: _bankNameController,
                accountNumberController: _accountNumberController,
                ibanController: _ibanController,
                taxIdController: _taxIdController,
              ),
              const SizedBox(height: 24),
              DocumentsSection(
                showMessage: _showMessage,
                existingDocuments: _existingDocuments,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}