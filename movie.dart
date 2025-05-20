import 'package:hive/hive.dart';

part 'movie.g.dart';

@HiveType(typeId: 0)
class Movie extends HiveObject {
  @HiveField(0) final String id;
  @HiveField(1) String title;
  @HiveField(2) int? year;
  @HiveField(3) String? genre;
  @HiveField(4) String? imagePath;

  Movie({
    required this.id,
    required this.title,
    this.year,
    this.genre,
    this.imagePath,
  });
}