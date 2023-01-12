import 'package:flutter/material.dart';

import '../models/models.dart';

class MovieSilder extends StatefulWidget {
  final List<Movie> movies;
  final Function onNextPage;

  const MovieSilder(
      {super.key, required this.movies, required this.onNextPage});

  @override
  State<MovieSilder> createState() => _MovieSilderState();
}

class _MovieSilderState extends State<MovieSilder> {
  final ScrollController scrollController = new ScrollController();

//Ejecutar codigo primera ves que el widget es construido
  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

//Cuando el Widget va ser destruido.
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 220.0,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(left: 20, bottom: 2),
          child: Text(
            "More Popular",
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'Lato',
                color: Colors.orange.shade500,
                letterSpacing: 3),
          ),
        ),

        //Expanded toma todo el tamaño que queda disponible
        Expanded(
          child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal, //Scroll horizontal
              itemCount: widget.movies.length,
              itemBuilder: (_, int index) {
                return _MoviePoster(movie: widget.movies[index]);
              }),
        )
      ]),
    );
  }
}

//Widget Privado, va vivir solamente dentro del Movie_Slider.dart

class _MoviePoster extends StatelessWidget {
  final Movie movie;

  const _MoviePoster({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 124,
      height: 180,
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
      child: Column(children: [
        //Imagenes de peliculas del MovieSolder. GestureDetector me permite implementar el onTap
        GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, 'details', arguments: movie),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(movie.fullPosterImg),
              width: 100,
              height: 138,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 5), //Separacion entre widgets
        // Titulo de la pelicula
        Text(
          movie.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        )
      ]),
    );
  }
}
