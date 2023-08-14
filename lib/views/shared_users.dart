import 'package:cinemate/constants/app_colours.dart';
import 'package:cinemate/constants/ui_constants.dart';
import 'package:cinemate/widgets/shared_user.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

final List users = [
  {
    "image": "images/her.jpeg",
    "color": Colors.purple[200],
    "name": "Ena",
    "isActive": false,
  },
  {
    "image": "images/vidur.png",
    "color": Colors.green[200],
    "name": "Maven",
    "isActive": true,
  },
];

class SharedUsers extends StatelessWidget {
  const SharedUsers({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // padding: Insets.horizontalPadding24.add(Insets.verticalPadding48),
          children: [
            Spacing.verticalSpace48,
            heading(theme),
            Spacing.verticalSpace24,
            addedUsers(),
            const Spacer(),
            editUsers(theme),
          ],
        ),
      ),
    );
  }

  Text heading(ThemeData theme) {
    return Text(
      "Who's watching?",
      style: theme.textTheme.headlineMedium!
          .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
      textAlign: TextAlign.center,
    );
  }

  Column addedUsers() {
    return Column(
      children: users
          .map(
            (user) => Container(
              margin: const EdgeInsets.only(top: 56.0),
              child: SharedUser(
                onPressed: () {},
                name: user["name"],
                isActive: user["isActive"],
                bgColor: user["color"],
                image: user["image"],
              ),
            ),
          )
          .toList(),
    );
  }

  Padding editUsers(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(48),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        FloatingActionButton(
          elevation: 0.0,
          shape: const CircleBorder(),
          backgroundColor: theme.colorScheme.onInverseSurface.withOpacity(0.1),
          onPressed: () {},
          child: const Center(
            child: Icon(
              LucideIcons.plus,
              color: AppColours.onBg,
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            "Edit",
            style: theme.textTheme.bodyLarge!.copyWith(
                color: theme.primaryColor, fontWeight: FontWeight.w600),
          ),
        )
      ]),
    );
  }
}
