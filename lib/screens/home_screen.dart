import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/providers/movies_provider.dart';
import 'package:movie_app/search/search_delegate.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/search/search_delegate.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Trae la instancia de movie provider y la coloca aqui. listen redibuja si el widget tiene una dependencia
    final moviesProvider = Provider.of<MovieProvider>(context);

    print(moviesProvider.onDisplayMovies);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'MOVIES',
            style: TextStyle(
                fontSize: 24,
                fontFamily: 'Lato',
                color: Colors.orange.shade700,
                letterSpacing: 3),
          ),
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
            colors: [Color(0xe3171717), Color(0xeb2e2e2e)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ))),
          toolbarHeight: 64,
          elevation: 8,
          actions: [
            //Icon Search
            IconButton(
                padding: const EdgeInsets.only(right: 14.0),
                iconSize: 30,
                onPressed: () => showSearch(
                    context: context, delegate: MovieSearchDelegate()),
                icon: Icon(
                  Icons.search_outlined,
                  color: Colors.orange.shade700,
                ))
          ],
        ),
        body: SingleChildScrollView(
          //Permite hacer Scroll
          child: Column(
            //Listado Horizontal de Movies
            children: [
              //Tarjetas Principales
              CardSwiper(movies: moviesProvider.onDisplayMovies),

              //Slider Peliculas
              MovieSilder(
                movies: moviesProvider.onDisplayPopularMovies,
                onNextPage: () => moviesProvider.getPopularMovies(),
              )
            ],
          ),
        ));
  }
}
