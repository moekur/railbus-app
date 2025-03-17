import 'package:flutter/material.dart';

class QuickActionsComponent extends StatelessWidget {
  final VoidCallback onHistoryTap;
  final VoidCallback onKYCTap;
  final VoidCallback onSupportTap;

  const QuickActionsComponent({
    required this.onHistoryTap,
    required this.onKYCTap,
    required this.onSupportTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionTile(context, icon: Icons.history, label: 'History', onTap: onHistoryTap),
        _buildActionTile(context, icon: Icons.upload_file, label: 'KYC', onTap: onKYCTap),
        _buildActionTile(context, icon: Icons.message, label: 'Support', onTap: onSupportTap),
      ],
    );
  }

  Widget _buildActionTile(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 28, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}