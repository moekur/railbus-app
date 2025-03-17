import 'package:flutter/material.dart';
import 'package:railbus/ui/screens/profile_screen.dart';

class HeaderComponent extends StatelessWidget {
  final String shareholderName;

  const HeaderComponent({required this.shareholderName, super.key});

  Future<void> _navigateToProfile(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            'Welcome, $shareholderName',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              onPressed: () => _navigateToProfile(context),
              icon: CircleAvatar(
                radius: 20,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: Text(
                  shareholderName[0],
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
