import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'movie.dart';
import 'storage_service.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final StorageService storageService;

  MovieBloc(this.storageService) : super(MovieLoading()) {
    on<LoadMovies>(_onLoadMovies);
    on<AddMovie>(_onAddMovie);
    on<UpdateMovie>(_onUpdateMovie);
    on<DeleteMovie>(_onDeleteMovie);
  }

  Future<void> _onLoadMovies(LoadMovies event, Emitter<MovieState> emit) async {
    emit(MovieLoading());
    try {
      final movies = await storageService.getAllMovies();
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  Future<void> _onAddMovie(AddMovie event, Emitter<MovieState> emit) async {
    await storageService.addMovie(event.movie);
    add(LoadMovies());
  }

  Future<void> _onUpdateMovie(UpdateMovie event, Emitter<MovieState> emit) async {
    await storageService.updateMovie(event.movie);
    add(LoadMovies());
  }

  Future<void> _onDeleteMovie(DeleteMovie event, Emitter<MovieState> emit) async {
    await storageService.deleteMovie(event.movie);
    add(LoadMovies());
  }
}