import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../api/tmdb_service.dart';
import '../models/movie.dart';
import '../providers/favorites_provider.dart';

class DetailsScreen extends StatefulWidget {
  final String movieId;

  const DetailsScreen({super.key, required this.movieId});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Future<Movie> _movieDetail;

  // Função para voltar para a tela inicial
  void _goBack(BuildContext context) {
    context.go('/');
  }

  @override
  void initState() {
    super.initState();
    // Inicia a busca pelos detalhes do filme assim que a tela é criada.
    _movieDetail = TmdbService().getMovieDetails(int.parse(widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    // Usamos um Consumer para ter acesso ao provider de favoritos.
    return Consumer<FavoritesProvider>(
      builder: (context, favoritesProvider, child) {
        return Scaffold(
          body: FutureBuilder<Movie>(
            future: _movieDetail,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Erro ao carregar os detalhes: ${snapshot.error}',
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              }

              if (snapshot.hasData) {
                final movie = snapshot.data!;
                final isFavorite = favoritesProvider.isFavorite(movie);

                // CustomScrollView permite criar efeitos de rolagem avançados.
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 250.0,
                      pinned: true, // Mantém o AppBar visível ao rolar
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          movie.title,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        background: CachedNetworkImage(
                          imageUrl: TmdbService.getBackdropUrl(
                            movie.backdropPath,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      actions: [
                        // O botão de favoritar na AppBar.
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.white,
                          ),
                          onPressed: () {
                            favoritesProvider.toggleFavorite(movie);
                          },
                        ),
                      ],
                    ),

                    // O corpo da tela de detalhes que pode ser rolado.
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nota média: ${movie.voteAverage.toStringAsFixed(1)} / 10',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Sinopse',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                movie.overview,
                                style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  _goBack(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1e3799),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Voltar',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ],
                );
              }

              return const Center(child: Text('Nenhum detalhe encontrado!'));
            },
          ),
        );
      },
    );
  }
}
