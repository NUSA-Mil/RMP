import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'movie.dart';

class AddEditMovieScreen extends StatefulWidget {
  final Movie? movie;
  final int? index;

  AddEditMovieScreen({this.movie, this.index});

  @override
  _AddEditMovieScreenState createState() => _AddEditMovieScreenState();
}

class _AddEditMovieScreenState extends State<AddEditMovieScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late int? _year;
  late String? _genre;
  File? _image;

  @override
  void initState() {
    super.initState();
    _title = widget.movie?.title ?? '';
    _year = widget.movie?.year;
    _genre = widget.movie?.genre;
    if (widget.movie?.imagePath != null) {
      _image = File(widget.movie!.imagePath!);
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  void _saveMovie() {
    if (!_formKey.currentState!.validate()) return;

    final newMovie = Movie(
      id: widget.movie?.id ?? DateTime.now().toString(),
      title: _title,
      year: _year,
      genre: _genre,
      imagePath: _image?.path,
    );

    // Проверка изменений для существующего фильма
    if (widget.movie != null) {
      final oldMovie = widget.movie!;
      final hasChanges = 
          oldMovie.title != _title ||
          oldMovie.year != _year ||
          oldMovie.genre != _genre ||
          oldMovie.imagePath != _image?.path;

      if (!hasChanges) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Нет изменений для сохранения')),
        );
        Navigator.pop(context);
        return;
      }
    }

    final movieBox = Hive.box<Movie>('movies');
    if (widget.index != null) {
      movieBox.putAt(widget.index!, newMovie);
    } else {
      movieBox.add(newMovie);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie == null ? 'Добавить фильм' : 'Редактировать фильм'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null ? Icon(Icons.add_a_photo, size: 40) : null,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Название фильма', border: OutlineInputBorder()),
                validator: (value) => value?.isEmpty ?? true ? 'Пожалуйста, введите название' : null,
                onSaved: (value) => _title = value!,
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: _year?.toString(),
                decoration: InputDecoration(labelText: 'Год выпуска', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onSaved: (value) => _year = value?.isNotEmpty == true ? int.parse(value!) : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: _genre,
                decoration: InputDecoration(labelText: 'Жанр', border: OutlineInputBorder()),
                onSaved: (value) => _genre = value,
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Отмена', style: TextStyle(fontSize: 18)),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveMovie,
                      child: Text('Сохранить', style: TextStyle(fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}