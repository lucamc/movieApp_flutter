import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwiper({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context)
        .size; //El MediaQuery facilita información relacionada con el dispositivo que se esta usando.

    return SizedBox(
        //Card Swiper
        width: double
            .infinity, //Que tome todo el ancho posible basado en el padre.
        height: size.height * 0.55, //Tomo la mitad de la pantalla 0.5 50%.
        child: Swiper(
          //Utilizo el Swiper. itemCount, Cantidad que quiero manejar
          itemCount: movies.length,
          layout: SwiperLayout.STACK, // layout
          itemWidth: size.width * 0.52,
          itemHeight: size.height * 0.41,
          itemBuilder: (_, int index) {
            //Builder algo que se va contruir de manera dinamica

            final movie = movies[index];
            print(movie.fullPosterImg);

            return GestureDetector(
              //Me va permitir ponerle en onTap, cuando alguien haga tap, realizo una nvegacion a otra pantalla.
              onTap: () => Navigator.pushNamed(context, 'details',
                  arguments:
                      'movie-instance'), //Con navigator pushNamed me permite navegar a otra pantalla.
              child: ClipRRect(
                //ClipRRect para agregarle Borde
                borderRadius: BorderRadius.circular(18), //redondear los bordes
                child: FadeInImage(
                  placeholder:
                      AssetImage('assets/img/no-image.jpg'), //Imagen en memoria
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit
                      .cover, // fit, para adaptar la imagen al contenedor padre.
                ),
              ),
            );
          },
        ));
  }
}
