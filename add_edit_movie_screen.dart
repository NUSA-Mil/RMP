import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'movie.dart';

class AddEditMovieScreen extends StatefulWidget {
  final Movie? movie;
  final int? index;

  const AddEditMovieScreen({this.movie, this.index});

  @override
  _AddEditMovieScreenState createState() => _AddEditMovieScreenState();
}

class _AddEditMovieScreenState extends State<AddEditMovieScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _yearText; 
  late String _genre;
  File? _image;

  @override
  void initState() {
    super.initState();
    _title = widget.movie?.title ?? '';
    _yearText = widget.movie?.year?.toString() ?? '';
    _genre = widget.movie?.genre ?? '';
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
    _formKey.currentState!.save();

    final newMovie = Movie(
      id: widget.movie?.id ?? DateTime.now().toString(),
      title: _title,
      year: _yearText.isNotEmpty ? int.tryParse(_yearText) : null,
      genre: _genre.isNotEmpty ? _genre : null,
      imagePath: _image?.path,
    );

    final box = Hive.box<Movie>('movies');
    if (widget.index != null) {
      box.putAt(widget.index!, newMovie);
    } else {
      box.add(newMovie);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie == null ? 'Добавить фильм' : 'Редактировать'),
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
                  backgroundImage: _image != null 
                      ? FileImage(_image!) 
                      : null,
                  child: _image == null 
                      ? Icon(Icons.add_a_photo, size: 40) 
                      : null,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(
                  labelText: 'Название*',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => 
                    value?.isEmpty ?? true ? 'Обязательное поле' : null,
                onSaved: (value) => _title = value!,
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: _yearText,
                decoration: InputDecoration(
                  labelText: 'Год',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) => _yearText = value ?? '',
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: _genre,
                decoration: InputDecoration(
                  labelText: 'Жанр',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _genre = value ?? '',
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Отмена'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveMovie,
                      child: Text('Сохранить'),
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