import 'package:cinemate/constants/app_colours.dart';
import 'package:cinemate/constants/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SharedUser extends StatelessWidget {
  const SharedUser({
    super.key,
    required this.onPressed,
    required this.name,
    required this.isActive,
    required this.bgColor,
    required this.image,
  });
  final GestureTapCallback onPressed;
  final String name;
  final bool isActive;
  final Color bgColor;
  final String image;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: bgColor,
          backgroundImage: AssetImage(image),
          child: InkWell(
            borderRadius: BorderRadius.circular(999),
            onTap: onPressed,
          ),
        ),
        Spacing.verticalSpace8,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isActive)
              const Icon(
                LucideIcons.lock,
                color: AppColours.onBg,
                size: 16,
              ),
            if (!isActive) Spacing.horizontalSpace4,
            Text(
              name,
              style: theme.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold, color: AppColours.onBg),
            ),
          ],
        )
      ],
    );
  }
}
