import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import './providers/favorites_provider.dart';
import './screens/details_screen.dart';
import './screens/favorites_screen.dart';
import './screens/home_screen.dart';
import './widgets/scaffold_with_nav_bar.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

// Configuração do GoRouter
final _router = GoRouter(
  initialLocation: '/',
  routes: [
    // Rota "Shell" para telas com a barra de navegação inferior
    ShellRoute(
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen()
        ),
        GoRoute(
          path: '/favorites',
          builder: (context, state) => const FavoritesScreen()
        )
      ]
    ),
    // Rota de Detalhes (fica fora da ShellRoute para aparecer por cima da barra de navegação)
    GoRoute(
      path: '/movie/:id',
      builder: (context, state) {
        final movieId = state.pathParameters['id']!;
        return DetailsScreen(movieId: movieId);
      }
    )
  ]
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Configuração do Provider
    // ChangeNotifierProvider envolve toda a aplicação, tornando o FavoritesProvider
    // acessível de qualquer lugar da árvore de widgets.
    return ChangeNotifierProvider(
      create: (context) => FavoritesProvider(),
      child: MaterialApp.router(
        title: 'Movie Catalog App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: const Color(0xFF1e3799),
          scaffoldBackgroundColor: const Color(0xFF0d1117),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF4a69db),
            secondary: Color(0xFF4a69db),
          ),
          fontFamily: 'Roboto',
        ),
        routerConfig: _router,
      )
    );
  }
}

