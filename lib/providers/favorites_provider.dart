import 'package:flutter/material.dart';
import '../models/movie.dart';

// A classe estende ChangeNotifier. Isso permite que ela notifique os 'ouvintes' (widgets)
class FavoritesProvider extends ChangeNotifier {
  final List<Movie> _favoriteMovies = [];

  List<Movie> get favoriteMovies => _favoriteMovies;

  void addFavorite(Movie movie) {
    _favoriteMovies.add(movie);
    // notifiyListeners() é o coração do Provider. Ele avisa todos os widgets
    // que estão 'ouvindo' este provider que o estado mudou e que eles precisam se reconstruir.
    notifyListeners();
  }

  void removeFavorite(Movie movie) {
    _favoriteMovies.remove(movie);
    notifyListeners();
  }

  bool isFavorite(Movie movie) {
    return _favoriteMovies.any((item) => item.id == movie.id);
  }

  void toggleFavorite(Movie movie) {
    if (isFavorite(movie)) {
      removeFavorite(movie);
    } else {
      addFavorite(movie);
    }
  }
}
