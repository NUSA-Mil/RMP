import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:io';
import 'movie.dart';
import 'add_edit_movie_screen.dart';

class MovieListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Мои фильмы'),
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
            return Center(child: Text('Добавьте первый фильм'));
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
                      content: Text('Удалить "${movie.title}"?'),
                      actions: [
                        TextButton(
                          child: Text('Отмена'),
                          onPressed: () => Navigator.of(ctx).pop(false),
                        ),
                        TextButton(
                          child: Text('Удалить', style: TextStyle(color: Colors.red)),
                          onPressed: () => Navigator.of(ctx).pop(true),
                        ),
                      ],
                    ),
                  );
                },
                onDismissed: (_) => box.deleteAt(index),
                child: ListTile(
                  leading: movie.imagePath != null
                      ? CircleAvatar(
                          backgroundImage: FileImage(File(movie.imagePath!)),
                        )
                      : CircleAvatar(child: Icon(Icons.movie)),
                  title: Text(movie.title),
                  subtitle: Text(
                    '${movie.year?.toString() ?? "Год не указан"}'
                    '${movie.genre != null ? " • ${movie.genre}" : ""}',
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditMovieScreen(
                        movie: movie,
                        index: index,
                      ),
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