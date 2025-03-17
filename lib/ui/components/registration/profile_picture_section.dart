import 'package:flutter/material.dart';

class ProfilePictureSection extends StatelessWidget {
  final String name;
  final VoidCallback onCameraPressed;

  const ProfilePictureSection({
    super.key,
    required this.name,
    required this.onCameraPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : 'U',
              style: const TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: IconButton(
                icon: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                onPressed: onCameraPressed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}