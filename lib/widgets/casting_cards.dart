import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/movies_provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;

  const CastingCards(this.movieId);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MovieProvider>(context, listen: false);

    return FutureBuilder(
        future: moviesProvider.getMoviesCast(movieId),
        builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              constraints: BoxConstraints(maxWidth: 120),
              height: 180,
              child: CircularProgressIndicator(
                color: Colors.orangeAccent,
              ),
            );
          }

          final cast = snapshot.data!;

          return Column(
            children: [
              const Text(
                "Actors",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Lato",
                    color: Colors.orangeAccent,
                    letterSpacing: 2),
              ),
              SizedBox(height: 14),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                width: double.infinity,
                height: 200,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (_, int index) {
                      return _CastCards(cast[index]);
                    }),
              ),
            ],
          );
        });
  }
}

class _CastCards extends StatelessWidget {
  final Cast actor;

  const _CastCards(this.actor);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 78,
      height: 160,
      child: Column(
        children: [
          //Imagen de actores

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(actor.fullProfileImg),
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(height: 6),

          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
