import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/movie_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Usando o Consumer do Provider
    // O widget Consumer ouve as mudanças no FavoritesProvider e reconstrói
    // a UI sempre que `notifyListeners()` é chamado.
    return Consumer<FavoritesProvider>(
      builder: (context, favoritesProvider, child) {
        // Pega a lista de filmes do provider
        final favoritesMovies = favoritesProvider.favoriteMovies;

        // Se a lista de favoritos estiver vazia, exibe uma mensagem.
        if (favoritesMovies.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Nenhum filme favorito adicionado.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                )
              ],
            )
          );
        }

        // Se houver favoritos, exibe-os em uma grade.
        return GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: favoritesMovies.length,
          itemBuilder: (context, index) {
            final movie = favoritesMovies[index];
            return MovieCard(movie: movie);
          },
        );
      }
    );
  }

}