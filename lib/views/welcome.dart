import 'package:cinemate/constants/app_colours.dart';
import 'package:cinemate/constants/ui_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: Insets.horizontalPadding24.add(Insets.verticalPadding48),
          children: [
            // Spacing.verticalSpace48,
            Text(
              "Welcome to \nCinemate",
              style: theme.textTheme.headlineMedium!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            featuresSection(theme),
            buttonsSection(theme),
          ],
        ),
      ),
    );
  }

  Widget featuresSection(ThemeData theme) {
    final List<Map<String, dynamic>> features = [
      {
        "colour": Colors.amber[600],
        "icon": LucideIcons.plus,
        "title": "Room",
        "description":
            "Bring the joy of communal viewing to long-distance relationships and groups of friends.",
      },
      {
        "colour": theme.primaryColor,
        "icon": LucideIcons.galleryVerticalEnd,
        "title": "Library",
        "description":
            "Access a comprehensive library of blockbuster movies at your fingertips.",
      },
      {
        "colour": const Color(0xFFCA1BB9),
        "icon": LucideIcons.search,
        "title": "Search",
        "description":
            "Uncover a vast selection of movies to enhance your joint viewing experience.",
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      itemCount: features.length,
      separatorBuilder: (ctx, idx) => const SizedBox(
        height: 32.0,
      ),
      itemBuilder: (ctx, idx) => ListTile(
        minVerticalPadding: 0,
        contentPadding: EdgeInsets.zero,
        tileColor: theme.scaffoldBackgroundColor,
        leading: CircleAvatar(
          backgroundColor: features[idx]["colour"],
          child: Icon(
            features[idx]["icon"],
            color: Colors.white,
          ),
        ),
        title: Text(
          features[idx]["title"],
          style: theme.textTheme.titleMedium!
              .copyWith(fontWeight: FontWeight.w600, color: AppColours.title),
        ),
        subtitle: Text(
          features[idx]["description"],
          style: theme.textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColours.subtitle,
          ),
        ),
      ),
    );
  }

  Widget buttonsSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Spacing.verticalSpace48,
        CupertinoButton(
          color: theme.primaryColor,
          child: Text(
            "Get started",
            style: theme.textTheme.titleMedium!
                .copyWith(fontWeight: FontWeight.w600, color: AppColours.title),
          ),
          onPressed: () {},
        ),
        Spacing.verticalSpace16,
        CupertinoButton(
          child: Text.rich(
            style: theme.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
            ),
            TextSpan(
              text: "Already have an account? ",
              style: const TextStyle(color: AppColours.subtitle),
              children: [
                TextSpan(
                  text: "Log in",
                  style: TextStyle(color: theme.primaryColor),
                ),
              ],
            ),
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
