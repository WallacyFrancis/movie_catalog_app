import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/movie.dart';

class TmdbService {
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  Future<List<Movie>> getPopularMovies() async {
    final apiKey = dotenv.env['TMDB_API_KEY'];

    if (apiKey == null) {
      throw Exception('Chave de API não encontrada');
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/movie/popular/api_key=$apiKey&langage=pt-BR'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      return results.map((movieJson) => Movie.fromJson(movieJson)).toList();
    } else {
      throw Exception('Falha ao carregar os filmes populares');
    }
  }

  static String getPosterUrl(String path) {
    if (path.isEmpty) {
      return 'https://placehold.co/500x750/16213e/FFFFFF?text=Imagem\nIndisponível';
    }

    return '$_imageBaseUrl$path';
  }

}