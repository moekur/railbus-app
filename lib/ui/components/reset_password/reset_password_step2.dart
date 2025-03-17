import 'package:flutter/material.dart';

class ResetPasswordStep2 extends StatelessWidget {
  final TextEditingController codeController;
  final bool isLoading;
  final VoidCallback onVerifyCode;
  final FormFieldValidator<String>? validator;

  const ResetPasswordStep2({
    super.key,
    required this.codeController,
    required this.isLoading,
    required this.onVerifyCode,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: codeController,
          decoration: InputDecoration(
            labelText: 'Reset Code',
            filled: true,
            fillColor: Colors.white.withOpacity(0.9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            labelStyle: const TextStyle(color: Colors.black87),
          ),
          style: const TextStyle(color: Colors.black87),
          keyboardType: TextInputType.number,
          validator: validator ??
              (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter the reset code';
                }
                return null;
              },
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: isLoading ? null : onVerifyCode,
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
                  'Verify Code',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
        ),
      ],
    );
  }
}