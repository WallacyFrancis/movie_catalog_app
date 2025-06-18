import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/movie.dart';

class TmdbService {
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const _backdropBaseUrl = 'https://image.tmdb.org/t/p/w780';

  // --- MÉTODOS DE BUSCA ---
  Future<List<Movie>> getPopularMovies() async {
    final response = await _get('/movie/popular');
    final List<dynamic> results = response['results'];
    return results.map((movieJson) => Movie.fromJson(movieJson)).toList();
  }

  // Método para buscar detalhes de um filme específico ---
  Future<Movie> getMovieDetails(int movieId) async {
    final response = await _get('/movie/$movieId');
    return Movie.fromJson(response);
  }

  // Método privado para centralizar a lógica da chamada GET ---
  Future<Map<String, dynamic>> _get(String path) async {
    final apiKey = dotenv.env['TMDB_API_KEY'];
    if (apiKey == null) {
      throw Exception('Chave da API não encontrada no arquivo .env');
    }

    final response = await http.get(
      Uri.parse('$_baseUrl$path?api_key=$apiKey&language=pt-BR'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar dados da API');
    }
  }

  // --- MÉTODOS PARA CONSTRUIR URLs DE IMAGEM ---
  static String getPosterUrl(String path) {
    if (path.isEmpty) {
      return 'https://placehold.co/500x750/16213e/FFFFFF?text=Imagem\nIndisponível';
    }
    return '$_imageBaseUrl$path';
  }

  // Método para a imagem de fundo na tela de detalhes ---
  static String getBackdropUrl(String path) {
    if (path.isEmpty) {
      return 'https://placehold.co/780x439/16213e/FFFFFF?text=Imagem\nIndisponível';
    }
    return '$_backdropBaseUrl$path';
  }
}