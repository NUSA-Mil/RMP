import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'movie.dart';
import 'add_edit_movie_screen.dart';

class MovieListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Мои любимые фильмы'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: ValueListenableBuilder<Box<Movie>>(
        valueListenable: Hive.box<Movie>('movies').listenable(),
        builder: (context, box, _) {
          if (box.isEmpty) {
            return Center(
              child: Text('Добавьте ваш первый фильм!', style: TextStyle(fontSize: 18)),
            );
          }
          
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final movie = box.getAt(index) as Movie;
              return Dismissible(
                key: Key(movie.id),
                background: Container(color: Colors.red),
                confirmDismiss: (direction) async {
                  return await showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('Удалить фильм?'),
                      content: Text('Вы уверены, что хотите удалить "${movie.title}"?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(false),
                          child: Text('Отмена'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(true),
                          child: Text('Удалить', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                },
                onDismissed: (direction) {
                  box.deleteAt(index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Фильм "${movie.title}" удалён')),
                  );
                },
                child: ListTile(
                  leading: movie.imagePath != null
                      ? CircleAvatar(backgroundImage: FileImage(movie.imagePath as dynamic))
                      : CircleAvatar(child: Icon(Icons.movie)),
                  title: Text(movie.title),
                  subtitle: Text(
                    '${movie.year != null ? movie.year.toString() : "Год неизвестен"}'
                    '${movie.genre != null ? " • ${movie.genre}" : ""}',
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditMovieScreen(movie: movie, index: index),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddEditMovieScreen()),
        ),
      ),
    );
  }
}