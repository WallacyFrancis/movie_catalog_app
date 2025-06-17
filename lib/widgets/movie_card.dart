import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../api/tmdb_service.dart';
import '../models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 1. Ao tocar no card, navegamos pra tela de detalhes do filme
      onTap: () {
        // Usando o GoRouter para navegar pra tela de telalhes passando o ID
        context.go('/movie/${movie.id}');
      },
      child: Card(
        elevation: 5,
        clipBehavior: Clip.antiAlias, // Garante que a imagem respeite as bordas arredondadas
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Estica os filhos para preencher a largura
          children: [
            // Imagem do filme com cache
            Expanded(
              child: CachedNetworkImage(
                // O pacote cached_network_image carrega a imagem e a armazena em cache,
                // melhorando muito a performance em listas.
                imageUrl: TmdbService.getPosterUrl(movie.posterPath),
                fit: BoxFit.cover,
                // Widget mostrado enquanto a imagem está carregando
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                // Widget mostrado se ocorrer um erro ao carregar a imagem
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            // Título do filme
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.title,
                textAlign: TextAlign.center,
                maxLines: 2, // Limita o tamanho do título do filme para duas linhas
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14
                ),
              ),
            ),
          ],
        ),
      )
    );
  } 
}