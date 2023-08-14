import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinemate/constants/ui_constants.dart';
import 'package:cinemate/models/movie.dart';
import 'package:cinemate/views/movie_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeroCard extends StatelessWidget {
  final Movie movie;
  const HeroCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    const imagePath = "https://image.tmdb.org/t/p/original";
    
    return InkWell(
      onTap: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => MovieDetails(id: movie.id,))),
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          height: ScreenSize.width,
          // width: ScreenSize.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                "$imagePath${movie.posterPath}",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
