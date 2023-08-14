import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinemate/constants/ui_constants.dart';
import 'package:cinemate/models/movie.dart';
import 'package:cinemate/views/movie_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    const imagePath = "https://image.tmdb.org/t/p/original";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => MovieDetails(
                id: movie.id,
              ),
            ),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              height: ScreenSize.height / 4.5,
              width: ScreenSize.width / 3,
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
        ),
        Spacing.verticalSpace8,
        Text(
          movie.originalTitle!,
          style: theme.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        Row(
          children: [
            Text(
              "${movie.voteAverage} • ",
              style: theme.textTheme.bodySmall,
            ),
            Text(
              "• ",
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}
// class MovieCard extends StatelessWidget {
//   final Movie movie;
//   const MovieCard({super.key, required this.movie});

//   @override
//   Widget build(BuildContext context) {

//     return InkWell(
//       child: Material(
//         child: Column(
//           children: [
//             Container(
//               height: ScreenSize.height,
//               width: ScreenSize.width,
//               
//             ),
//             Spacing.verticalSpace8,
            
//             Spacing.horizontalSpace4,
//             
//           ],
//         ),
//       ),
//     );
//   }
// }
