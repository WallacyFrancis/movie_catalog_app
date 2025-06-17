import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// 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
// https://github.com/WallacyFrancis/movie_catalog_app.git

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

