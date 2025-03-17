import 'package:flutter/material.dart';

class PersonalInformationSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController? passwordController; // Made nullable
  final TextEditingController? confirmPasswordController; // Made nullable
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController countryController;
  final VoidCallback onNameChanged;
  final bool isEditable;

  const PersonalInformationSection({
    super.key,
    required this.nameController,
    required this.emailController,
    this.passwordController, // Optional
    this.confirmPasswordController, // Optional
    required this.phoneController,
    required this.addressController,
    required this.countryController,
    required this.onNameChanged,
    this.isEditable = true,
  });

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
              'Personal Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.black87),
              ),
              style: const TextStyle(color: Colors.black87),
              validator: isEditable
                  ? (value) => value == null || value.trim().isEmpty ? 'Please enter your full name' : null
                  : null,
              onChanged: (value) => onNameChanged(),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.black87),
              ),
              style: const TextStyle(color: Colors.black87),
              keyboardType: TextInputType.emailAddress,
              validator: isEditable
                  ? (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    }
                  : null,
            ),
            if (passwordController != null) ...[
              const SizedBox(height: 12),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.black87),
                ),
                style: const TextStyle(color: Colors.black87),
                obscureText: true,
                validator: isEditable
                    ? (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      }
                    : null,
              ),
            ],
            if (confirmPasswordController != null) ...[
              const SizedBox(height: 12),
              TextFormField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.black87),
                ),
                style: const TextStyle(color: Colors.black87),
                obscureText: true,
                validator: isEditable
                    ? (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != passwordController!.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      }
                    : null,
              ),
            ],
            const SizedBox(height: 12),
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.black87),
              ),
              style: const TextStyle(color: Colors.black87),
              keyboardType: TextInputType.phone,
              validator: isEditable
                  ? (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your phone number';
                      }
                      if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value)) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    }
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.black87),
              ),
              style: const TextStyle(color: Colors.black87),
              maxLines: 2,
              validator: isEditable
                  ? (value) => value == null || value.trim().isEmpty ? 'Please enter your address' : null
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: countryController,
              decoration: const InputDecoration(
                labelText: 'Country',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.black87),
              ),
              style: const TextStyle(color: Colors.black87),
              validator: isEditable
                  ? (value) => value == null || value.trim().isEmpty ? 'Please enter your country' : null
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}