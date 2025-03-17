import 'package:flutter/material.dart';

class ResetPasswordStep3 extends StatelessWidget {
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final bool isLoading;
  final VoidCallback onResetPassword;
  final FormFieldValidator<String>? newPasswordValidator;
  final FormFieldValidator<String>? confirmPasswordValidator;

  const ResetPasswordStep3({
    super.key,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.isLoading,
    required this.onResetPassword,
    this.newPasswordValidator,
    this.confirmPasswordValidator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: newPasswordController,
          decoration: InputDecoration(
            labelText: 'New Password',
            filled: true,
            fillColor: Colors.white.withOpacity(0.9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            labelStyle: const TextStyle(color: Colors.black87),
            suffixIcon: IconButton(
              icon: Icon(
                newPasswordController.text.isEmpty || newPasswordController.text == confirmPasswordController.text
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.black87,
              ),
              onPressed: () {
                // Toggle visibility only if there’s text or it matches confirm password
                if (newPasswordController.text.isNotEmpty) {
                  // Add your visibility toggle logic here if needed
                }
              },
            ),
          ),
          style: const TextStyle(color: Colors.black87),
          obscureText: true, // Default to obscured, toggle logic can be added if needed
          validator: newPasswordValidator ??
              (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a new password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: confirmPasswordController,
          decoration: InputDecoration(
            labelText: 'Confirm New Password',
            filled: true,
            fillColor: Colors.white.withOpacity(0.9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            labelStyle: const TextStyle(color: Colors.black87),
            suffixIcon: IconButton(
              icon: Icon(
                confirmPasswordController.text.isEmpty || confirmPasswordController.text == newPasswordController.text
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.black87,
              ),
              onPressed: () {
                // Toggle visibility only if there’s text or it matches new password
                if (confirmPasswordController.text.isNotEmpty) {
                  // Add your visibility toggle logic here if needed
                }
              },
            ),
          ),
          style: const TextStyle(color: Colors.black87),
          obscureText: true, // Default to obscured, toggle logic can be added if needed
          validator: confirmPasswordValidator ??
              (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please confirm your new password';
                }
                if (value != newPasswordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: isLoading ? null : onResetPassword,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            minimumSize: const Size(double.infinity, 50),
          ),
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : const Text(
                  'Reset Password',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
        ),
      ],
    );
  }
}