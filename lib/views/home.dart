import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinemate/constants/app_colours.dart';
import 'package:cinemate/constants/credentials.dart';
import 'package:cinemate/constants/ui_constants.dart';
import 'package:cinemate/models/movie.dart';
import 'package:cinemate/widgets/api_list_builder.dart';
import 'package:cinemate/widgets/hero_card.dart';
import 'package:cinemate/widgets/movie_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lucide_icons/lucide_icons.dart';

final List<Map<String, dynamic>> trailingWidgets = [
  {"name": "", "icon": LucideIcons.plus, "onTap": () {}},
  {"name": "", "icon": LucideIcons.galleryVerticalEnd, "onTap": () {}},
  {"name": "", "icon": LucideIcons.search, "onTap": () {}},
];

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Movie>? popularMovies = [];
  List<Movie>? upcomingMovies = [];

  Future<List<Movie>?> getPopularMovies() async {
    final url = Uri.parse(
      "https://api.themoviedb.org/3/movie/popular",
    );
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: tmdbAuthorizationHeader,
      HttpHeaders.acceptHeader: "application/json"
    });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final moviesList = jsonResponse["results"] as List<dynamic>;
      popularMovies = moviesList.map((e) => Movie.fromMap(e)).toList();
      return popularMovies;
    } else {
      debugPrint("Error ${response.body}");
    }
    return popularMovies;
  }

  Future<List<Movie>?> getUpcomingMovies() async {
    final url = Uri.parse(
      "https://api.themoviedb.org/3/movie/upcoming",
    );
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: tmdbAuthorizationHeader,
      HttpHeaders.acceptHeader: "application/json"
    });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final moviesList = jsonResponse["results"] as List<dynamic>;
      upcomingMovies = moviesList.map((e) => Movie.fromMap(e)).toList();
      return upcomingMovies;
    } else {
      debugPrint("Error ${response.body}");
    }
    return upcomingMovies;
  }

  @override
  void initState() {
    super.initState();
    // getPopularMovies();
  }

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: AppColours.bg,
        leading: const CircleAvatar(
          backgroundImage: AssetImage("images/vidur.png"),
        ),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: trailingWidgets
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: InkWell(
                    onTap: e["onTap"],
                    child: CircleAvatar(
                      backgroundColor: theme.canvasColor.withOpacity(0.15),
                      child: Icon(
                        e["icon"],
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Spacing.verticalSpace48,
          FutureBuilder<List<Movie>?>(
              future: getPopularMovies(),
              builder: (context, snapshot) {
                return APIListBuilder<List<Movie>?>(
                  nullIcon: LucideIcons.fileWarning,
                  nullLabel: "Empty",
                  nullSubLabel: "No movies found",
                  errorTitle: "Error",
                  errorSubtitle: "Could not fetch movies",
                  snapshot: snapshot,
                  buildWidget: Column(
                    children: [
                      CarouselSlider.builder(
                          carouselController: _controller,
                          options: CarouselOptions(
                            // height: ScreenSize.width,
                            aspectRatio: 8 / 10,
                            enableInfiniteScroll: false,
                            enlargeCenterPage: true,
                            autoPlay: false,
                            padEnds: false,
                          ),
                          itemCount: popularMovies?.length,
                          itemBuilder: (context, index, pageViewIndex) {
                            final movie = snapshot.data![index];
                            return Column(
                              children: [
                                Expanded(
                                  child: HeroCard(movie: movie),
                                ),
                                ListTile(
                                  title: Text(
                                    movie.originalTitle!,
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: AppColours.title),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Text(
                                        "${movie.releaseDate.toString().substring(0, 4)} • ",
                                        style: theme.textTheme.labelMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: AppColours.subtitle),
                                      ),
                                      Text(
                                        "${movie.voteAverage} • ",
                                        style: theme.textTheme.labelMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: AppColours.subtitle),
                                      ),
                                      Text(
                                        "${movie.originalLanguage!} • "
                                            .toUpperCase(),
                                        style: theme.textTheme.labelMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: AppColours.subtitle),
                                      ),
                                      const Icon(
                                        Icons.hd_outlined,
                                        size: 16.0,
                                        color: AppColours.subtitle,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                      Spacing.verticalSpace8,
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              "Rent \$9.99",
                              style: TextStyle(color: AppColours.bg),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            label: const Text(
                              "Watch trailer",
                              style: TextStyle(color: AppColours.onBg),
                            ),
                            icon: const Icon(
                              LucideIcons.playCircle,
                              color: AppColours.onBg,
                            ),
                          ),
                          const Spacer(),
                          IconButton.filledTonal(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      theme.canvasColor.withOpacity(0.1))),
                              onPressed: () {},
                              icon: const Icon(
                                LucideIcons.info,
                                color: AppColours.title,
                              ))
                        ],
                      )
                    ],
                  ),
                );
              }),
          Spacing.verticalSpace24,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Latest releases",
                style: theme.textTheme.titleLarge!
                    .copyWith(color: AppColours.subtitle),
              ),
              Spacing.verticalSpace12,
              FutureBuilder<List<Movie>?>(
                  future: getUpcomingMovies(),
                  builder: (context, snapshot) {
                    return APIListBuilder<List<Movie>?>(
                      nullIcon: LucideIcons.fileWarning,
                      nullLabel: "Empty",
                      nullSubLabel: "No movies found",
                      errorTitle: "Error",
                      errorSubtitle: "Could not fetch movies",
                      snapshot: snapshot,
                      buildWidget: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: ScreenSize.width,
                            maxHeight: ScreenSize.height / 3),
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: popularMovies?.length,
                            itemBuilder: (context, index) {
                              final movie = snapshot.data![index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: MovieCard(movie: movie),
                              );
                            }),
                      ),
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
