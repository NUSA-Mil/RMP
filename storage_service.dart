import 'package:hive/hive.dart';
import 'movie.dart';

class StorageService {
  Box<Movie> get _movieBox => Hive.box<Movie>('movies');

  Future<List<Movie>> getAllMovies() async {
    return _movieBox.values.toList();
  }

  Future<void> addMovie(Movie movie) async {
    await _movieBox.add(movie);
  }

  Future<void> updateMovie(Movie movie) async {
    await movie.save();
  }

  Future<void> deleteMovie(Movie movie) async {
    await movie.delete();
  }
}