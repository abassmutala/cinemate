import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinemate/constants/app_colours.dart';
import 'package:cinemate/constants/credentials.dart';
import 'package:cinemate/constants/ui_constants.dart';
import 'package:cinemate/models/movie.dart';
import 'package:cinemate/widgets/api_list_builder.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:http/http.dart' as http;

final List users = [
  {
    "image": "images/vidur.png",
    "color": Colors.green[200],
    "name": "Maven",
    "role": "Host",
  },
  {
    "image": "images/her.jpeg",
    "color": Colors.purple[200],
    "name": "Ena",
    "role": "Waiting to join...",
  },
];

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key, required this.id});
  final int id;

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late Movie? movie;
  late List? photos;

  Future<Movie?> getMovieDetails() async {
    final url = Uri.parse("https://api.themoviedb.org/3/movie/${widget.id}");
    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: tmdbAuthorizationHeader,
      HttpHeaders.acceptHeader: "application/json"
    });

    if (response.statusCode != 200) debugPrint("Error: ${response.body}");
    var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    movie = Movie.fromMap(jsonResponse);
    print(jsonResponse);
    return movie;
  }

  Future<List?> getMoviePhotos() async {
    final url =
        Uri.parse("https://api.themoviedb.org/3/movie/${widget.id}/images");
    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: tmdbAuthorizationHeader,
      HttpHeaders.acceptHeader: "application/json"
    });

    if (response.statusCode != 200) debugPrint("Error: ${response.body}");
    var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    photos = jsonResponse["backdrops"];
    return photos;
  }

  @override
  void initState() {
    super.initState();
    movie = null;
    photos = null;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return NestedScrollView(
      physics: const BouncingScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          sliverAppBar(context, innerBoxIsScrolled),
        ];
      },
      body: FutureBuilder<Movie?>(
          future: getMovieDetails(),
          builder: (context, snapshot) {
            return Material(
              type: MaterialType.transparency,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  specs(theme),
                  addFriendsTile(theme, context),
                  detailsContainer(theme)
                ],
              ),
            );
          }),
    );
  }

  Widget sliverAppBar(BuildContext context, bool innerBoxIsScrolled) {
    return SliverAppBar(
      backgroundColor: AppColours.bg,
      automaticallyImplyLeading: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(64.0),
          bottomRight: Radius.circular(64.0),
        ),
      ),
      actions: [
        IconButton.filledTonal(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              AppColours.surface,
            ),
          ),
          color: AppColours.onBg,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(LucideIcons.x),
        ),
        Spacing.horizontalSpace12
      ],
      expandedHeight: kToolbarHeight * 8,
      pinned: true,
      stretch: true,
      stretchTriggerOffset: 100,
      flexibleSpace: screenShots(innerBoxIsScrolled),
    );
  }

  Widget screenShots(bool innerBoxIsScrolled) {
    return FlexibleSpaceBar(
        background: ClipRRect(
          borderRadius: !innerBoxIsScrolled
              ? const BorderRadius.only(
                  bottomLeft: Radius.circular(64.0),
                  bottomRight: Radius.circular(64.0),
                )
              : BorderRadius.zero,
          child: FutureBuilder<List?>(
              future: getMoviePhotos(),
              builder: (context, snapshot) {
                return APIListBuilder<List?>(
                  nullIcon: LucideIcons.imageOff,
                  nullLabel: "No photos",
                  nullSubLabel: "No photos found",
                  errorTitle: "Error",
                  errorSubtitle: "Could not fetch photos",
                  snapshot: snapshot,
                  buildWidget: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: photos?.length,
                      itemBuilder: (context, index) {
                        const imagePath = "https://image.tmdb.org/t/p/original";
                        final photo = snapshot.data![index];
                        return CachedNetworkImage(
                          imageUrl: "$imagePath${photo!["file_path"]}",
                          progressIndicatorBuilder: (context, url, progress) =>
                              const CircularProgressIndicator.adaptive(),
                          fit: BoxFit.cover,
                        );
                      }),
                );
              }),
        ),
        stretchModes: const [
          StretchMode.zoomBackground,
        ],
        expandedTitleScale: 1,
        title: Padding(
          padding: Insets.verticalPadding12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  LucideIcons.playCircle,
                ),
                label: const Text("Watch movie"),
                style: const ButtonStyle(
                  elevation: MaterialStatePropertyAll(0.0),
                  backgroundColor: MaterialStatePropertyAll(AppColours.onBg),
                  foregroundColor: MaterialStatePropertyAll(AppColours.bg),
                ),
              ),
              Spacing.horizontalSpace12,
              IconButton.filledTonal(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    AppColours.surface,
                  ),
                ),
                color: AppColours.onBg,
                onPressed: () {},
                icon: const Icon(LucideIcons.plus),
              )
            ],
          ),
        ));
  }

  Widget specs(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${movie?.adult == false ? "PG-13" : "18+"}  •  ",
            style: theme.textTheme.bodyLarge,
          ),
          Text(
            "${movie?.releaseDate!.substring(0, 4)}  •  ",
            style: theme.textTheme.bodyLarge,
          ),
          const Icon(
            Icons.hd_outlined,
            size: 24.0,
            color: AppColours.subtitle,
          )
        ],
      ),
    );
  }

  Widget detailsContainer(ThemeData theme) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColours.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      margin: const EdgeInsets.only(top: 24.0),
      padding: Insets.verticalPadding24.add(Insets.horizontalPadding16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            movie!.originalTitle!,
            style: theme.textTheme.titleLarge,
          ),
          Spacing.verticalSpace12,
          Text(
            movie!.overview!,
            style: theme.textTheme.bodyLarge!.copyWith(height: 1.6),
            maxLines: 4,
          )
        ],
      ),
    );
  }

  Widget addFriendsTile(ThemeData theme, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColours.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: ListTile(
        contentPadding: Insets.horizontalPadding16,
        textColor: AppColours.onBg,
        title: Text(
          "Watching alone?",
          style: theme.textTheme.titleMedium,
        ),
        subtitle: Text(
          "Add some friends and make it a viewing party.",
          style:
              theme.textTheme.bodySmall!.copyWith(color: AppColours.subtitle),
        ),
        trailing: IconButton(
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(AppColours.onBg),
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => addViewersBottomSheet(theme, context),
            );
          },
          icon: const Icon(LucideIcons.plus),
        ),
      ),
    );
  }

  Widget addViewersBottomSheet(ThemeData theme, BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(32),
      ),
      child: SizedBox(
        height: ScreenSize.height * 0.95,
        child: Scaffold(
          backgroundColor: AppColours.surface,
          body: Container(
            padding: Insets.verticalPadding24.add(Insets.horizontalPadding16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Add viewers",
                      style: theme.textTheme.titleLarge!.copyWith(fontSize: 16),
                    ),
                    IconButton.filledTonal(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          AppColours.onBg.withOpacity(0.1),
                        ),
                      ),
                      color: AppColours.onBg,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(LucideIcons.x),
                    ),
                  ],
                ),
                Spacing.verticalSpace16,
                Column(
                  children: users
                      .map(
                        (user) => ListTile(
                          onTap: () {},
                          leading: CircleAvatar(
                            backgroundColor: user["color"],
                            backgroundImage: AssetImage(user["image"]),
                          ),
                          title: Text(
                            user["name"],
                            style: theme.textTheme.titleMedium,
                          ),
                          subtitle: Text(
                            user["role"],
                            style: theme.textTheme.bodySmall!
                                .copyWith(color: AppColours.subtitle),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const Spacer(),
                Column(
                  children: [
                    Text(
                      "Invite up to 10 friends",
                      style: theme.textTheme.titleMedium,
                    ),
                    Spacing.verticalSpace12,
                    Text(
                      "Bring the whole crew: Invite up to 10 friends for epic movie nights",
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: AppColours.subtitle),
                      textAlign: TextAlign.center,
                    ),
                    Spacing.verticalSpace24,
                    FloatingActionButton.large(
                      elevation: 0.0,
                      shape: const CircleBorder(),
                      backgroundColor: AppColours.onBg.withOpacity(0.1),
                      onPressed: () {},
                      child: const Center(
                        child: Icon(LucideIcons.plus),
                      ),
                    ),
                    Spacing.verticalSpace48
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
