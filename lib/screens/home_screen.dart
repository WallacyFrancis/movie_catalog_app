import 'package:flutter/material.dart';
import '../api/tmdb_service.dart';
import '../widgets/movie_card.dart';
import '../models/movie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Estado para armazenar a lista de files
  // Usando o Future para armazenar os estados assincronos
  late Future<List<Movie>> _popularMovies;
  final TmdbService _tmdbService = TmdbService();

  @override
  void initState() {
    super.initState();
    // A chamada a API será feita aqui uma única vez quando o widget é inicalizado
    _popularMovies = _tmdbService.getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    // A tela principal não precisa de um AppBar aqui, pois ele será gerenciado
    // em um nível superior junto com a barra de navegação.

    // Future Builder
    // Este é o widget perfeito para construir UI a partir de um Future (uma chamada de API).
    // Ele gerencia os diferentes estados: carregando, com erro e com dados.
    return FutureBuilder<List<Movie>>(
      future: _popularMovies,
      builder: (context, snapshot) {
        // Estado: Carregando
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Estado: Com Erro
        if (snapshot.hasError) {
          return Center(child: Text('Erro ao carregar os filmes: ${snapshot.error}'));
        }

        // Estado: Com Dados (Sucesso)
        if (snapshot.hasData) {
          final movies = snapshot.data!;
          // GridView é ideal para exibir uma grade de itens.
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 colunas
              childAspectRatio: 2 / 3, // Proporção dos Cards (larguga / altura)
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return MovieCard(movie: movie);
            },
          );
        }

      // Estado inicial ou sem dados
        return const Center(child: Text('Nenhum filme encontrado'));
      }
    );
  }
}