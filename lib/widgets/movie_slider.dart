import 'package:flutter/material.dart';

class MovieSilder extends StatelessWidget {
  const MovieSilder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 220.0,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "More Views",
            style: TextStyle(
                fontSize: 20, fontFamily: 'Lato', color: Colors.white),
          ),
        ),

        //Expanded toma todo el tamaño que queda disponible
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.horizontal, //Scroll horizontal
              itemCount: 20,
              itemBuilder: (_, int index) {
                return _MoviePoster();
              }),
        )
      ]),
    );
  }
}

//Widget Privado, va vivir solamente dentro del Movie_Slider.dart

class _MoviePoster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 114,
      height: 180,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(children: [
        //Imagenes de peliculas del MovieSolder. GestureDetector me permite implementar el onTap
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'details',
              arguments: 'movie-instance'),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/300x400'),
              width: 114,
              height: 138,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 5), //Separacion entre widgets
        // Titulo de la pelicula
        const Text(
          "StarsWars: El retonar del nuevo Jedi Silvestre",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        )
      ]),
    );
  }
}
