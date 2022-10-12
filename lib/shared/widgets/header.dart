import 'package:flutter/material.dart';
import 'package:video_player_app/shared/widgets/back_navigator.dart';
import 'package:video_player_app/shared/widgets/spacing.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const BackNavigator(),
        const XMargin(16),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
