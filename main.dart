import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app_theme.dart';
import 'movie.dart';
import 'movie_list_screen.dart';
import 'settings_screen.dart';
import 'storage_service.dart';
import 'theme_cubit.dart';
import 'movie_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MovieAdapter());
  await Hive.openBox<Movie>('movies');

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(
          create: (context) => MovieBloc(StorageService())..add(LoadMovies()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkMode) {
        return MaterialApp(
          title: 'Movie App',
          theme: isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
          home: MovieListScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}