import 'package:flutter/material.dart';

import 'package:movie_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class MovieSearchDelegate extends SearchDelegate {
  //Para cambiar al español el search
  // @override
  // String get searchFieldLabel => 'Buscar';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          //Limpiar la Busqueda
          onPressed: () {
            query = '';
          })
    ];
  }

//Retornar al home.
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildResults');
  }

  Widget _emptyContainer() {
    return Container(
      child: Center(
          child: Icon(
        Icons.movie_creation_outlined,
        size: 130,
      )),
    );
    ;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container(
        child: Center(
            child: Icon(
          Icons.movie_creation_outlined,
          size: 130,
        )),
      );
    }

    final moviesProvider = Provider.of<MovieProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.searchMovies(query),
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return _emptyContainer();
        }

        final movies = snapshot.data!;

        return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (_, int index) => _MovieItem(movie: movies[index]));
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage(
        placeholder: AssetImage('assets/img/no-image.jpg'),
        image: NetworkImage(movie.fullbackdropPath),
        width: 144,
        height: 90,
        fit: BoxFit.fitWidth,
      ),
      title: Text(
        movie.title,
        style: TextStyle(color: Colors.orangeAccent),
      ),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}
