import 'package:flutter/material.dart';

class QuickActionsComponent extends StatelessWidget {
  final VoidCallback onBuySharesTap;
  final VoidCallback onTransactionHistoryTap;
  final VoidCallback onAnnualReportsTap;
  final VoidCallback onNewsTap;

  const QuickActionsComponent({
    required this.onBuySharesTap,
    required this.onTransactionHistoryTap,
    required this.onAnnualReportsTap,
    required this.onNewsTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionTile(
          context,
          icon: Icons.shopping_cart,
          label: 'Buy Shares',
          onTap: onBuySharesTap,
        ),
        _buildActionTile(
          context,
          icon: Icons.history,
          label: 'Transactions',
          onTap: onTransactionHistoryTap,
        ),
        _buildActionTile(
          context,
          icon: Icons.description,
          label: 'Reports',
          onTap: onAnnualReportsTap,
        ),
        _buildActionTile(
          context,
          icon: Icons.article,
          label: 'News',
          onTap: onNewsTap,
        ),
      ],
    );
  }

  Widget _buildActionTile(
      BuildContext context, {
        required IconData icon,
        required String label,
        required VoidCallback onTap,
      }) {
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